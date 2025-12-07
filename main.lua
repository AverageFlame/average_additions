mod_dir = ''..SMODS.current_mod.path

AVE = {}

-- SMODS reset_game_globals function - called on run start (true) and run end (false)
--[[ function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        -- Initialize/reset variables at the start of a new run
        ave_initialize_variables()
    else
        -- Clean up variables at the end of a run
        ave_cleanup_variables()
    end
end ]]

-- Function to initialize AVE mod variables for a new run
function ave_initialize_variables()
    -- Initialize core AVE structure
    AVE.MAP = AVE.MAP or { paths = {}, levels = {} }
    AVE.MAP.selectable_levels = {}
    AVE.MAP.current_stage = nil
    AVE.MAP.current_level = {}
    AVE.MAP.limit = nil
    
    AVE.rarity = nil
    AVE.rarity_weights = {}
end

-- Function to clean up all AVE mod variables
function ave_cleanup_variables()
    -- Clean up map-related variables
    if AVE.MAP then
        if AVE.MAP.paths then
            AVE.MAP.paths = {}
        end
        if AVE.MAP.levels then
            AVE.MAP.levels = {}
        end
        if AVE.MAP.selectable_levels then
            AVE.MAP.selectable_levels = {}
        end
        if AVE.MAP.cell_icon then
            -- Remove any UI elements that might still exist
            for i = 1, #AVE.MAP.cell_icon do
                if AVE.MAP.cell_icon[i] then
                    for j = 1, #AVE.MAP.cell_icon[i] do
                        if AVE.MAP.cell_icon[i][j] and AVE.MAP.cell_icon[i][j].remove then
                            AVE.MAP.cell_icon[i][j]:remove()
                        end
                    end
                end
            end
            AVE.MAP.cell_icon = {}
        end
        AVE.MAP.current_stage = nil
        AVE.MAP.current_level = {}
        AVE.MAP.limit = nil
    end
    
    -- Clean up other AVE variables
    AVE.rarity = nil
    AVE.rarity_weights = {}
    
    -- Clean up the map UI if it exists
    if AVE.map then
        AVE.map:remove()
        AVE.map = nil
    end
end

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
