local args, AVE
args = { ... }
AVE = args[1]

local scrollWheel = 0
local scroll = 0
local scrolling = false
local scroll_amount = 0
AVE.MAP.selectable_levels = {}
AVE.rarity = nil
AVE.MAP.current_stage = nil
AVE.MAP.current_level = {}
AVE.rarity_weights = {}
AVE.MAP.paths = {}
--local Ave_small_blind = {name = 'Small Blind',  defeated = false, order = 1, dollars = 3, mult = 1,  vars = {}, debuff_text = '', debuff = {}, pos = {x=0, y=0}}
--local Ave_big_blind = {name = 'Big Blind',    defeated = false, order = 2, dollars = 4, mult = 1.5,vars = {}, debuff_text = '', debuff = {}, pos = {x=0, y=1}}

G.FUNCS.ave_select = function (e)
  ave_select_level(e)
end

function ave_select_level(e)
  local cellRow = e.ability.map_id.row
  local cellColumn = e.ability.map_id.column
  AVE.MAP.current_level[1] = cellRow
  AVE.MAP.current_level[2] = cellColumn
  AVE.MAP.current_stage = e.config.center
  AVE.MAP.current_stage:modify()
  for i = 1, AVE.MAP.dim.columns do
    AVE.MAP.selectable_levels[cellRow][i] = 0
    if AVE.MAP.current_level[1] > 1 and AVE.MAP.selectable_levels[AVE.MAP.current_level[1]-1][i] == 2 then
      AVE.MAP.selectable_levels[AVE.MAP.current_level[1]-1][i] = 3
    end
  end
  AVE.MAP.selectable_levels[cellRow][cellColumn] = 2

  for i = 1, #AVE.MAP.levels do
    for j = 1, AVE.MAP.dim.columns do
       AVE.MAP.cell_icon[i][j]:remove()
       AVE.MAP.cell_icon[i][j] = nil
    end
  end
  AVE.map:remove()
  ave_map_loaded = false
  if AVE.map then
    AVE.map.cardarea = nil
    AVE.map.align_cards = nil
    AVE.map = nil
  end
  if G.GAME.round_resets.blind_states.Small == 'Select' then
    G.STATE = G.STATES.BLIND_SELECT
    G.STATE_COMPLETE = false
  end
  if G.GAME.round_resets.blind_states.Small == 'Upcoming' then
    G.STATE = G.STATES.SHOP
    G.STATE_COMPLETE = false
  end
end

function ave_copyBlind(blind)
  local t = {}
    for k, v in pairs(blind) do t[k] = v end
    return t
end

function ave_followPaths()
  local map_cycle_level = #AVE.MAP.levels
  for _, v in pairs(AVE.MAP.paths) do
    local targetRow, targetColumn
    local cellRow = tonumber(string.match(v[1].parent.config.id, '%d+'))
    local cellColumn = tonumber(string.match(v[1].parent.config.id, '%d+', 3))
    if cellRow == AVE.MAP.current_level[1] and cellColumn == AVE.MAP.current_level[2] then
      targetRow = tonumber(string.match(v[2].parent.config.id, '%d+'))
      targetColumn = tonumber(string.match(v[2].parent.config.id, '%d+', 3))
      if AVE.MAP.current_level[1] == map_cycle_level then
        targetRow = targetRow % map_cycle_level
      end
      AVE.MAP.selectable_levels[targetRow][targetColumn] = 1
    end
  end
end

local ave_timer = 0
local ave_map_loaded = false
function Ave_Update_Map(dt)
  -- This is called every frame, so G.STATE_COMPLETE is used to only load shop once
  if not G.STATE_COMPLETE then
    local map_cycle_level = #AVE.MAP.levels
    -- moves along the path to next level
    if G.GAME.round_resets.blind_states.Small == 'Upcoming' then
      -- Follow the paths to selectable levels
      ave_followPaths()
      AVE.MAP.current_stage:remove()
      -- Knock the first half of the rows off of the map (so we can generate new ones)
      if AVE.MAP.current_level[1] == map_cycle_level then
        AVE.MAP.paths = {}
        for _ = 1, map_cycle_level do
          table.remove(AVE.MAP.levels, 1)
        end
      end
    end
    scrollWheel = 0

    -- Initial level generation
    if next(AVE.MAP.levels) == nil or AVE.MAP.current_level[1] == map_cycle_level then
      for i = 1, G.GAME.win_ante do
        generateLevel(i)
      end
      for col = 1, AVE.MAP.dim.columns do
        for i = 2, #AVE.MAP.levels do
          AVE.MAP.selectable_levels[i][col] = 0
        end
        AVE.MAP.selectable_levels[1][col] = 1
      end
    else
      for col = 1, AVE.MAP.dim.columns do
        if AVE.MAP.selectable_levels[1][col] ~= 2 then
          AVE.MAP.selectable_levels[1][col] = 0
        end
      end
    end

    -- Stages UI
    stop_use() -- prevent use of consumables
    ease_background_colour_blind(G.STATES.SHOP) --change background color
    AVE.map = UIBox{ -- this has to get redefined every time unfortunately, because it gets deleted after every selection
      definition = createMapUI(), --definiton for shop UI, points to UI_definitions.lua
      config = {id = 'MAINMAP', align = 'tm', major = G.ROOM_ATTACH, offset = {x = 2.75, y = -5}, bond = 'Weak', instance_type = 'CARDAREA'}
    }
    if not AVE.map.cardarea then AVE.map.cardarea = CardArea(AVE.map.T.x, AVE.map.T.y, AVE.MAP.dim.w, AVE.MAP.dim.h * #AVE.MAP.levels,
      {card_limit = #AVE.MAP.levels * AVE.MAP.dim.columns, type = 'Stage'}) end
    if not AVE.map.align_cards then AVE.map.align_cards = function() end end

    for i = #AVE.MAP.levels, 1, -1 do
      ave_create_row_UI(i)
    end
    ave_create_icons()

    -- initializing paths
    if next(AVE.MAP.paths) == nil then
      for i = 1, #AVE.MAP.levels - 1 do
        ave_generateRow(i)
      end
    -- Moves the paths down by half
    elseif AVE.MAP.current_level[1] == map_cycle_level then
      for i = 1, #AVE.MAP.levels - 1 do
        ave_generateRow(i)
      end
      AVE.MAP.current_level[1] = 0
    -- Reloading the paths otherwise
    else
      ave_reloadPaths()
    end

    -- Stages UI Nonsense
    local ave_map_offset = G.ROOM.T.h + (AVE.map.T.h / 2) - (AVE.map:get_UIE_by_ID('aveScroll').T.h/2) + (AVE.MAP.current_level[1] and ((AVE.MAP.current_level[1] * AVE.MAP.dim.h) - AVE.MAP.dim.h) or 0)
    AVE.MAP.limit = {}
    AVE.MAP.limit.top = AVE.map:get_UIE_by_ID('aveScroll').T.h/2 + AVE.map.T.h/2
    AVE.MAP.limit.bot = G.ROOM.T.h + (AVE.map.T.h / 2) - (AVE.map:get_UIE_by_ID('aveScroll').T.h/2)
    ---[[
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      blockable = false,
      func = function()
          aveDrawLine()
          AVE.map.alignment.offset.y = ave_map_offset
          if math.abs(AVE.map.T.y - AVE.map.VT.y) < 3 then
            G.ROOM.jiggle = G.ROOM.jiggle + 3
            play_sound('timpani')
          end
          ave_map_loaded = true
          return true
      end
      }))
      --]]
    G.STATE_COMPLETE = true
  end
  ave_timer = ave_timer + 1
  ave_map_scroll()
  if G.buttons then G.buttons:remove(); G.buttons = nil end
end

function get_current_stage()
  if AVE.MAP.current_stage then
    return AVE.MAP.current_stage
  else
    return nil
  end
end

function love.wheelmoved(x, y)
  if y > 0 then
    scrollWheel = scrollWheel + 1
  elseif y < 0 then
    scrollWheel = scrollWheel - 1
  end
end

function ave_map_scroll()
  if G.STATE == 32 and G.STATE_COMPLETE and ave_map_loaded then
    if AVE.map then
      if not G.CONTROLLER.is_cursor_down then
        -- if map too low, raise it
        ---[[
        if AVE.map.alignment.offset.y < AVE.MAP.limit.bot then
          AVE.map.alignment.offset.y = AVE.MAP.limit.bot
        end
        -- if map too high, lower it
        if AVE.map.alignment.offset.y > AVE.MAP.limit.top then
          AVE.map.alignment.offset.y = AVE.MAP.limit.top
        end--]]
        -- if cursor is over map stage, then prepare scroll values
        if G.ROOM.T.x + AVE.map.T.x < G.CURSOR.T.x and  G.CURSOR.T.x < G.ROOM.T.x + AVE.map.T.x + AVE.map.T.w then
          scroll = G.CURSOR.T.y
          scrolling = true
        else
          scrolling = false
        end
        if scrollWheel ~= 0 then
          AVE.map.alignment.offset.y = AVE.map.alignment.offset.y + scrollWheel
          scrollWheel = 0
        end
      end
      if G.CONTROLLER.is_cursor_down then
        if scrolling then
          scroll_amount = G.CURSOR.T.y - scroll
          if (AVE.map.alignment.offset.y < (AVE.MAP.limit.bot - 3.5) and scroll_amount > 0) then
            AVE.map.alignment.offset.y = AVE.map.alignment.offset.y + scroll_amount
          elseif (AVE.map.alignment.offset.y > (AVE.MAP.limit.top + 3.5) and scroll_amount < 0) then
            AVE.map.alignment.offset.y = AVE.map.alignment.offset.y + scroll_amount
          elseif (AVE.map.alignment.offset.y > (AVE.MAP.limit.bot - 3.5)) and (AVE.map.alignment.offset.y < (AVE.MAP.limit.top + 3.5)) then
            AVE.map.alignment.offset.y = AVE.map.alignment.offset.y + scroll_amount
          end
          scroll = G.CURSOR.T.y
        end
      end
    end
  end
end