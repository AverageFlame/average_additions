local scrollWheel = 0
local scroll = 0
local scrolling = false
local scroll_amount = 0
AVE.MAP.selectable_levels = {}
AVE.rarity = nil
AVE.MAP.current_stage = nil
AVE.MAP.current_level = {}
AVE.rarity_weights = {}
--local Ave_small_blind = {name = 'Small Blind',  defeated = false, order = 1, dollars = 3, mult = 1,  vars = {}, debuff_text = '', debuff = {}, pos = {x=0, y=0}}
--local Ave_big_blind = {name = 'Big Blind',    defeated = false, order = 2, dollars = 4, mult = 1.5,vars = {}, debuff_text = '', debuff = {}, pos = {x=0, y=1}}

G.FUNCS.ave_select = function (e)
  ave_select_level(e)
end

function ave_select_level(e)
  local cellR = tonumber(e.parent.config.id:sub(2,2))
  local cellC = tonumber(e.parent.config.id:sub(4,4))
  AVE.MAP.current_level[1] = cellR
  AVE.MAP.current_level[2] = cellC
  AVE.MAP.current_stage = e.config.center
  AVE.MAP.current_stage:modify()
  for i=1,AVE.MAP.dim.columns do
    AVE.MAP.selectable_levels[cellR][i] = 0
    if AVE.MAP.current_level[1] > 1 and AVE.MAP.selectable_levels[AVE.MAP.current_level[1]-1][i] == 2 then
      AVE.MAP.selectable_levels[AVE.MAP.current_level[1]-1][i] = 3
    end
  end
  AVE.MAP.selectable_levels[cellR][cellC] = 2
  for i=1,#AVE.MAP.levels do
    for j=1,AVE.MAP.dim.columns do
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
        if G.GAME.round_resets.blind_states.Small == 'Upcoming' then
          for k,v in pairs(AVE.MAP.paths) do
            local cellR = tonumber(v[1].parent.config.id:sub(1,1))
            local cellC = tonumber(v[1].parent.config.id:sub(3,3))
            if cellR == AVE.MAP.current_level[1] and cellC == AVE.MAP.current_level[2] then
              local targetR = tonumber(v[2].parent.config.id:sub(1,1))
              local targetC = tonumber(v[2].parent.config.id:sub(3,3))
              AVE.MAP.selectable_levels[targetR][targetC] = 1
            end
          end
          AVE.MAP.current_stage:remove()
        end
      scrollWheel = 0
      
      AVE.MAP.paths = AVE.MAP.paths or nil
      AVE.MAP.levels = AVE.MAP.levels or nil
      generateLevels()
      AVE.map = nil
      stop_use() -- prevent use of consumables
      ease_background_colour_blind(G.STATES.SHOP) --change background color
      AVE.map = AVE.map or UIBox{ -- if there isn't shop UI already, make it
        definition = createMapUI(), --definiton for shop UI, points to UI_definitions.lua
        config = {id = 'MAINMAP', align='tm',major = G.ROOM_ATTACH, offset = {x=0, y=-5}, bond = 'Weak', instance_type = 'CARDAREA'}
      }
      if not AVE.map.cards then AVE.map.cards = {} end
      if not AVE.map.align_cards then AVE.map.align_cards = function() end end
      ave_create_rows()
      ave_create_icons()
      if next(AVE.MAP.paths) == nil then
        ave_generatePaths()
      else
        ave_reloadPaths()
      end
      local ave_map_offset = G.ROOM.T.h + (AVE.map.T.h / 2) - (AVE.map:get_UIE_by_ID('aveScroll').T.h/2) + (AVE.MAP.current_level[1] and ((AVE.MAP.current_level[1] * AVE.MAP.dim.h) - AVE.MAP.dim.h) or 0)
      AVE.MAP.limit = {}
      AVE.MAP.limit.top = AVE.map:get_UIE_by_ID('aveScroll').T.h/2 + AVE.map.T.h/2
      AVE.MAP.limit.bot = G.ROOM.T.h + (AVE.map.T.h / 2) - (AVE.map:get_UIE_by_ID('aveScroll').T.h/2)
        ---[[
        G.E_MANAGER:add_event(Event({
                func = function()
                    AVE.map.alignment.offset.y = ave_map_offset
                    if AVE.map.T.y > -30 and math.abs(AVE.map.T.y - AVE.map.VT.y) < 3 then
                      G.ROOM.jiggle = G.ROOM.jiggle + 3
                      play_sound('polychrome1', 1.2, 0.7)
                      ave_map_loaded = true
                      return true
                    end
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


function get_current_stage()
  if AVE.MAP.current_stage then
    return AVE.MAP.current_stage
  else
    return nil
  end
end