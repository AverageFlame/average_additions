local noop

--Do nothing function. For when you need a function to exist, but don't
--want it to do anything.
function noop() end

--AVE *must* be global, since access to the table is needed within
--injected code. While it's possible to locally scope access to AVE in
--those files as well, it would incur more source code patches for little
--benefit; due to the lack of modularity of LocalThunk's code, benefits
--such as reducing clutter, preventing namespace collisions, and the like
--are all nullified.
AVE = {}

function SMODS.current_mod.reset_game_globals(start)
    if not start then return end

    AVE.MAP = AVE.MAP or {}

    -- Remove any UI elements that might still exist.
    for x = 1, #(AVE.MAP.cell_icon or {}), 1 do
        for y = 1, #(AVE.MAP.cell_icon[x] or {}), 1 do
            (AVE.MAP.cell_icon[x][y] or { remove = noop }):remove()
        end
    end

    --Remove map (map vs MAP?)
    (AVE.map or { remove = noop }):remove()

    AVE.MAP.paths = {}
    AVE.MAP.levels = {}
    AVE.MAP.centers = {}
    AVE.MAP.cell_icon = {}
    AVE.MAP.current_level = {}
    AVE.MAP.selectable_levels = {}
    AVE.rarity = nil
    if AVE.rarity_weights and AVE.rarity_weights ~= {} then
      for i = 1, #SMODS.ObjectTypes.Joker.rarities do
        if AVE.rarity_weights[i] then
            SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
        end
      end
    end
    AVE.rarity_weights = {}
    
    AVE.MAP.limit         = nil
    AVE.MAP.current_stage = nil

    AVE.map    = nil
    AVE.rarity = nil
end

assert(SMODS.load_file("stages.lua"))(AVE)
assert(SMODS.load_file("map_UI.lua"))(AVE)
assert(SMODS.load_file("dunsparce.lua"))(AVE)
assert(SMODS.load_file("map_functions.lua"))(AVE)

SMODS.Keybind {
  key_pressed = "g",
  action = function()

  end
}

SMODS.Keybind {
  key_pressed = "h",
  action = function()
	
  end
}

SMODS.Keybind {
  key_pressed = "j",
  action = function()
	
  end
}

SMODS.Keybind {
  key_pressed = "k",
  action = function()
	
  end
}
