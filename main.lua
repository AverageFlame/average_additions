local AVE
local noop

--Do nothing function. For when you need a function to exist, but don't
--want it to do anything.
function noop() end

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

    AVE.MAP.paths             = {}
    AVE.MAP.levels            = {}
    AVE.MAP.cell_icon         = {}
    AVE.MAP.current_level     = {}
    AVE.MAP.selectable_levels = {}
    
    AVE.rarity_weights = {}
    
    AVE.MAP.limit         = nil
    AVE.MAP.current_stage = nil

local helper, load_error = SMODS.load_file("map_UI.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end
local helper, load_error = SMODS.load_file("map_functions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end
local helper, load_error = SMODS.load_file("dunsparce.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end
local helper, load_error = SMODS.load_file("stages.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
    AVE.map    = nil
    AVE.rarity = nil
end





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
