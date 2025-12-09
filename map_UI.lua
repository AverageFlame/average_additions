local args, AVE

args = { ... }

AVE = args[1]

--local ave_brown = {0.5, 0.4, 0.3,1}
local ave_select = {0,0.8,1,1}
local ave_brown = {0.2, 0.2, 0.25,1}
AVE.MAP = AVE.MAP or { paths = {}, levels = {} }
-- map dimensions, columns is # of cells in a row, w is min width of the map, h is height of each row
AVE.MAP.dim = {columns = 4, w = 12, h = 3.5}
AVE.MAP.CELL = {}
AVE.MAP.CELL.dim = { h = 2.1, w = (AVE.MAP.dim.w / AVE.MAP.dim.columns) - (0.6 / AVE.MAP.dim.columns) }

function ave_generatePaths()
  AVE.MAP.paths = {}
  for i = 1,#AVE.MAP.levels - 1 do
    ave_generateRow(i)
  end
end
-- creates a list of paths between map cells
function ave_generate_cell(i,j,count,finalCount)
  local lines = 0
  for k = 1, AVE.MAP.dim.columns do
    count[k] = finalCount[k]
  end
if j == 1 then
      c1 = pseudorandom(pseudoseed('leftEdge'..i),1 ,3)
      if c1 == 1 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        count[j] = count[j] + 1
        lines = lines + 1
      else if c1 == 2 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j+1).children[1]) 
        count[j+1] = count[j+1] + 1
        lines = lines + 1
      else
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j+1).children[1])
        count[j] = count[j] + 1
        count[j+1] = count[j+1] + 1
        lines = lines + 2
      end end
    else if j == AVE.MAP.dim.columns then
      c3 = pseudorandom(pseudoseed('rightEdge'..i),1 ,3)
      if c3 == 1 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1]) 
        count[j] = count[j] + 1
        lines = lines + 1
      else if c3 == 2 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j-1).children[1]) 
        count[j-1] = count[j-1] + 1
        lines = lines + 1
      else
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j-1).children[1])
        count[j-1] = count[j-1] + 1
        count[j] = count[j] + 1
        lines = lines + 2
      end end
      if count[j] == 0 or count[j-1] == 0 or (AVE.MAP.dim.columns <= 3 and (count[j] > 2 or count[j-1] > 2)) then
        for l=1,lines do
          table.remove(AVE.MAP.paths)
        end
        ave_generate_cell(i,j,count,finalCount) 
      end
    else
      c2 = pseudorandom(pseudoseed('cell'..i..j),1 ,6)
      if c2 == 1 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j-1).children[1])
        count[j-1] = count[j-1] + 1
        lines = lines + 1
      else if c2 == 2 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        count[j] = count[j] + 1
        lines = lines + 1
      else if c2 == 3 then 
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        count[j] = count[j] + 1
        lines = lines + 1
      else if c2 == 4 then 
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j-1).children[1])
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        count[j-1] = count[j-1] + 1
        count[j] = count[j] + 1
        lines = lines + 2
      else if c2 == 5 then
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j).children[1])
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j+1).children[1])
        count[j] = count[j] + 1
        count[j+1] = count[j+1] + 1
        lines = lines + 2
      else
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j-1).children[1])
        ave_addPath(AVE.map:get_UIE_by_ID(i..'-'..j).children[1], AVE.map:get_UIE_by_ID((i+1)..'-'..j+1).children[1])
        count[j-1] = count[j-1] + 1
        count[j+1] = count[j+1] + 1
        lines = lines + 2
      
      end end end end end 
	  -- if any column has 0 paths or too many paths, redo this cell
        if count[j-1] == 0 or (AVE.MAP.dim.columns <= 3 and (count[j] > 2 or count[j-1] > 2 or count[j+1] > 2)) then
        for l=1,lines do
          table.remove(AVE.MAP.paths)
        end
        ave_generate_cell(i,j,count,finalCount) 
      end
    end 
  end
end

function ave_generateRow(i)
  local finalCount = {}
  local count = {}
  for k = 1, AVE.MAP.dim.columns do
    finalCount[k] = 0
    count[k] = 0
  end
  for j = 1, AVE.MAP.dim.columns do
    ave_generate_cell(i,j,count,finalCount)
    for k = 1, AVE.MAP.dim.columns do
      finalCount[k] = count[k]
    end
  end
end



function ave_addPath(a, b)
    table.insert(AVE.MAP.paths, {a, b})
end

local ave_fade_target = 0
function aveDrawLine()
  if G.STATE == 32 and G.STATE_COMPLETE and AVE.map then
    for i=1,3 do
      ave_select[i] = G.C.DYN_UI.MAIN[i]
    end
    -- Update Selection Color to fade in/out
    local min_alpha, max_alpha = 0, 1
    ave_scale = G.TILESIZE*G.TILESCALE
    -- Switch direction at bounds
    if ave_select[4] <= min_alpha then
      ave_select[4] = min_alpha
      ave_fade_target = 1
    elseif ave_select[4] >= max_alpha then
      ave_select[4] = max_alpha
      ave_fade_target = 0
    end

    -- fade in/out
    local max_speed = 0.01
    local min_speed = 0.001 -- <-- add this
    local t = (ave_select[4] - min_alpha) / (max_alpha - min_alpha)
    local speed = (1 - t) * max_speed + min_speed
    if ave_fade_target == 1 then
      -- Fade in (alpha increasing, slow as it approaches 1)
      ave_select[4] = ave_select[4] + speed
    else
      -- Fade out (alpha decreasing, fast as it leaves 1)
      ave_select[4] = ave_select[4] - speed
    end
    
    love.graphics.push()
    love.graphics.setLineWidth(ave_scale * 0.1)
    love.graphics.setColor(ave_brown) 
    for i, v in ipairs(AVE.MAP.paths) do
      n1 = v[1]
      n2 = v[2]
      n1x = (n1.VT.x + (n1.VT.w/2))*ave_scale + G.ROOM.T.x*ave_scale
      n1y = n1.VT.y*ave_scale + G.ROOM.T.y*ave_scale + 0.1*ave_scale
      n2x = (n2.VT.x + (n2.VT.w/2))*ave_scale + G.ROOM.T.x*ave_scale 
      n2y = (n2.VT.y + n2.VT.h)*ave_scale + G.ROOM.T.y*ave_scale - 0.1*ave_scale 
      if n2y < (G.ROOM.T.h+G.ROOM.T.y+4)*ave_scale then
        ---[[
        if AVE.MAP.current_level and AVE.MAP.current_level[1] and n1 == AVE.map:get_UIE_by_ID(AVE.MAP.current_level[1]..'-'..AVE.MAP.current_level[2]).children[1] then
          love.graphics.setColor(ave_select)
          love.graphics.setLineWidth(ave_scale * 0.2)
          love.graphics.line(n1x, n1y, n2x, n2y)
          love.graphics.setLineWidth(ave_scale * 0.1)
          love.graphics.setColor(ave_brown)
        end
        --]]
        love.graphics.line(n1x, n1y, n2x, n2y)
      end
    end
    ave_debug = 0
    love.graphics.pop()
  end
end

-- creates the actual clickable card icons for each map cell
function ave_create_icons()
 AVE.MAP.cell_icon = {}
for i=1, #AVE.MAP.levels do
   AVE.MAP.cell_icon[i] = {}
  for j=1,AVE.MAP.dim.columns do 
    local card = Card(0, 0, G.CARD_W, G.CARD_H, nil, AVE.MAP.levels[i][j])
    --local card = SMODS.create_card({key = AVE.MAP.levels[i][j].key})
    card.states.collide.can = true
    card.states.hover.can = true
    card.states.drag.can = false
    if AVE.MAP.selectable_levels[i][j] == 1 then
      card.states.click.can = true
    else
      card.states.click.can = false
    end
    card.click = G.FUNCS.ave_select
     AVE.MAP.cell_icon[i][j] =  {}
     AVE.MAP.cell_icon[i][j] = UIBox{
        definition = {n=G.UIT.ROOT, config ={align = "cm", colour = G.C.CLEAR, padding = -0.25, minw = 3}, nodes={
            {n=G.UIT.O, config={id = 'c'..i..'-'..j, object = card}}}},
        config = {align='cm', instance_type = 'CARD',colour = G.C.CLEAR, major = AVE.map:get_UIE_by_ID(i..'-'..j), bond = 'Strong', role_type = 'Minor'}
      }
    if not  AVE.MAP.cell_icon[i][j].cards then  AVE.MAP.cell_icon[i][j].cards = {} end
    if not  AVE.MAP.cell_icon[i][j].align_cards then  AVE.MAP.cell_icon[i][j].align_cards = function() end end
  end
end
return  AVE.MAP.cell_icon
end

-- fills in each row of the map with the "background" color for each cell. Also marks selectable cells.
function ave_create_rows()
  for i = #AVE.MAP.levels,1,-1 do
    if i == #AVE.MAP.levels then height = 0 end
    AVE.map:add_child( {n=G.UIT.R, config={id = "r-"..i,align = "bm", colour = G.C.CLEAR, minw = AVE.MAP.dim.w, minh = height, padding = 0.1, r = 1}}, AVE.map:get_UIE_by_ID("aveScroll").children[1] )
    for j = 1,AVE.MAP.dim.columns do
      if AVE.MAP.selectable_levels[i][j] == 1 then
        select_color = ave_select
      else if AVE.MAP.selectable_levels[i][j] == 2 then
        select_color = G.C.GREEN
      else if AVE.MAP.selectable_levels[i][j] == 3 then
        select_color = G.C.GREY
      else
        select_color = G.C.CLEAR
      end end end
      AVE.map:add_child( {n=G.UIT.C, config={id = i..'-'..j, align = "bm", colour = G.C.CLEAR, minw = AVE.MAP.CELL.dim.w, minh = AVE.MAP.CELL.dim.h}, nodes={
        {n=G.UIT.R, config={align = "cm", colour = select_color, padding = 0.05, r = 0.1}, nodes={
          {n=G.UIT.C, config={align = "cm", colour = ave_brown, minw = 3, minh = AVE.MAP.CELL.dim.h, r = 0.1}}
        }}
      }}, AVE.map:get_UIE_by_ID("r-"..i))
      select_color = G.C.CLEAR
    end
  height = AVE.MAP.dim.h
  end
end

-- selects the stages for each map cell and stores them in AVE.MAP.levels
function generateLevels()
    if next(AVE.MAP.levels) == nil then
		-- G.GAME.win_ante is usually 8
		for i=1,G.GAME.win_ante do
		AVE.MAP.levels[i] = {}
		AVE.MAP.selectable_levels[i] = {}
		for j=1,AVE.MAP.dim.columns do
			local _pool, _pool_key = get_current_pool("Stage", nil, nil, nil)
			local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
			local it = 1
			while center == 'UNAVAILABLE' do
				it = it + 1
				center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
			end
			center = G.P_CENTERS[center]
			AVE.MAP.levels[i][j] = {}
			AVE.MAP.levels[i][j] = center
			AVE.MAP.selectable_levels[i][j] = {}
			if G.GAME.round_resets.ante % G.GAME.win_ante == 1 and i == 1 then
			AVE.MAP.selectable_levels[i][j] = 1
			else
			AVE.MAP.selectable_levels[i][j] = 0
			end
		end
		end
  	end
end

-- creates the overall map UI structure
function createMapUI()
  mapUI = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, maxw = AVE.MAP.dim.w}, nodes={
      {n=G.UIT.C, config = {align = "cm", padding= 0.03, colour = G.C.UI.TRANSPARENT_DARK, r=0.1}, nodes={
        {n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
          {n=G.UIT.C, config={align = "tm", colour = G.C.DYN_UI.BOSS_DARK, minw = 0, minh = 0, r = 0.1, padding = 0.08}, nodes={
            {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, minh = 8}},
            {n=G.UIT.R, config={id = 'map_wrapper', align = "bm", minh = 0, colour = G.C.DYN_UI.MAIN, maxw = AVE.MAP.dim.w, padding = 0.05, r=0.1}, nodes={
              {n=G.UIT.C, config={id = 'aveScroll', align = "cm", minw = 11, maxw = AVE.MAP.dim.w, r = 0.1, colour = G.C.DYN_UI.BOSS_DARK, padding = 0.1, func = 'ave_scroll'}, nodes={
                -- wrapper for extra ante rows
                {n=G.UIT.R, config={id = 'extra_rows', align = "bm", colour = G.C.CLEAR, minw = AVE.MAP.dim.w, minh = 18}}
              }}
            }},
            {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, minh = 8}}
          }}
        }}
      }}
    }}
  return mapUI
end

function ave_reloadPaths()
  for i, v in ipairs(AVE.MAP.paths) do
    AVE.MAP.paths[i][1] = AVE.map:get_UIE_by_ID(v[1].parent.config.id).children[1]
    AVE.MAP.paths[i][2] = AVE.map:get_UIE_by_ID(v[2].parent.config.id).children[1]
  end
end