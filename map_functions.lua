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
  local cellRow = tonumber(e.parent.config.id:sub(2,2))
  local cellColumn = tonumber(e.parent.config.id:sub(4,4))
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
  if AVE.MAP.current_level[1] > 1 and AVE.MAP.current_level[1] % (G.GAME.win_ante / 2) == 1 then
    cellRow = cellRow % (G.GAME.win_ante / 2)
    AVE.MAP.selectable_levels[cellRow][cellColumn] = 2
  else
    AVE.MAP.selectable_levels[cellRow][cellColumn] = 2
  end
  for i = 1, #AVE.MAP.levels do
    for j = 1, AVE.MAP.dim.columns do
       AVE.MAP.cell_icon[i][j]:remove()
       AVE.MAP.cell_icon[i][j] = nil
    end
  end
  AVE.map:remove()
  ave_map_loaded = false
  if AVE.map then
    AVE.map.cards = nil
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

local ave_timer = 0
local ave_map_loaded = false
function Ave_Update_Map(dt)
    -- This is called every frame, so G.STATE_COMPLETE is used to only load shop once
    if not G.STATE_COMPLETE then
      AVE.MAP.paths = AVE.MAP.paths or nil
      AVE.MAP.levels = AVE.MAP.levels or nil
      -- moves along the path to next level
      if G.GAME.round_resets.blind_states.Small == 'Upcoming' then
        -- Follow the paths to selectable levels
        for _, v in pairs(AVE.MAP.paths) do
          local targetRow, targetColumn
          local cellRow = tonumber(v[1].parent.config.id:sub(1,1))
          local cellColumn = tonumber(v[1].parent.config.id:sub(3,3))
          if cellRow == AVE.MAP.current_level[1] and cellColumn == AVE.MAP.current_level[2] then
            targetRow = tonumber(v[2].parent.config.id:sub(1,1))
            targetColumn = tonumber(v[2].parent.config.id:sub(3,3))
            if AVE.MAP.current_level[1] > 1 and AVE.MAP.current_level[1] % (G.GAME.win_ante / 2) == 1 then
              targetRow = targetRow % (G.GAME.win_ante / 2)
            end
            AVE.MAP.selectable_levels[targetRow][targetColumn] = 1
          end
        end
        AVE.MAP.current_stage:remove()
        -- Knock the first half of the rows off of the map (so we can generate new ones)
        if AVE.MAP.current_level[1] > 1 and AVE.MAP.current_level[1] % (G.GAME.win_ante / 2) == 1 then
          -- clear out the paths from rows 1 through win_ante / 2
          local new_paths = {}
          for _, v in pairs(AVE.MAP.paths) do
            if tonumber(v[1].parent.config.id:sub(1,1)) > (G.GAME.win_ante / 2) then
              new_paths[#new_paths+1] = v
            end
          end
          AVE.MAP.paths = new_paths
          for _ = 1, G.GAME.win_ante / 2 do
            table.remove(AVE.MAP.levels, 1)
          end
        end
      end
      scrollWheel = 0

      -- Initial level generation
      if next(AVE.MAP.levels) == nil then
        for i = 1, G.GAME.win_ante do
          generateLevel(i)
        end
        for col = 1, AVE.MAP.dim.columns do
          AVE.MAP.selectable_levels[1][col] = 1
        end
      -- Generating levels post-cycle
      elseif AVE.MAP.current_level[1] > 1 and AVE.MAP.current_level[1] % (G.GAME.win_ante / 2) == 1 then
        for i = G.GAME.win_ante / 2 + 1, G.GAME.win_ante do
          generateLevel(i)
        end
      -- base case
      else
        for col = 1, AVE.MAP.dim.columns do
          if AVE.MAP.selectable_levels[1][col] ~= 2 then
            AVE.MAP.selectable_levels[1][col] = 0
          end
        end
      end

      -- Stages UI
      AVE.map = nil
      stop_use() -- prevent use of consumables
      ease_background_colour_blind(G.STATES.SHOP) --change background color
      AVE.map = AVE.map or UIBox{ -- if there isn't shop UI already, make it
        definition = createMapUI(), --definiton for shop UI, points to UI_definitions.lua
        config = {id = 'MAINMAP', align = 'tm', major = G.ROOM_ATTACH, offset = {x = 2.75, y = -5}, bond = 'Weak', instance_type = 'CARDAREA'}
      }
      if not AVE.map.cards then AVE.map.cards = {} end
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
      elseif AVE.MAP.current_level[1] > 1 and AVE.MAP.current_level[1] % (G.GAME.win_ante / 2) == 1 then
        for _, v in ipairs(AVE.MAP.paths) do
          ave_movePath(v, G.GAME.win_ante / 2)
        end
        for i = G.GAME.win_ante / 2, #AVE.MAP.levels - 1 do
          ave_generateRow(i)
        end
        AVE.MAP.current_level[1] = AVE.MAP.current_level[1] - (G.GAME.win_ante / 2)
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
                func = function()
                    AVE.map.alignment.offset.y = ave_map_offset
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    play_sound('timpani')
                    ave_map_loaded = true
                    return true
                end
                }))
                --]]
        G.STATE_COMPLETE = true
    end
  ave_timer = ave_timer + 1
  ave_map_scroll()
  aveDrawLine()
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