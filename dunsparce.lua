
Ave_color = G.C.GREEN
local ave_reroll_button = nil
local Ave_red = nil
local Ave_green = nil
Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])

function Ave_assign_vars()
    ave_reroll_button = G.shop:get_UIE_by_ID('ui_reroll').parent
    Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])
    Ave_red = {n=G.UIT.R, config={align = "cm",}, nodes={
                {n=G.UIT.R, config={id = 'ui_reroll', align = "cm", minw = 2.8, minh = 1.6, r=0.15,colour = G.C.RED, button = 'reroll_shop', func = 'can_reroll', hover = true,shadow = true}, nodes={
                  {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                      {n=G.UIT.O, config={object = Dunsparce}},
                      {n=G.UIT.T, config={text = localize('ave_reroll'), scale = 1.5, colour = G.C.WHITE, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                      {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                      {n=G.UIT.T, config={ref_table = G.GAME.current_round, ref_value = 'reroll_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                    }}
                  }}
                }}
              }}

    Ave_green = {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.R, config={id = 'ui_reroll', align = "cm", minw = 2.8, minh = 1.6, r=0.15,colour = G.C.GREEN, button = 'reroll_shop', func = 'can_reroll', hover = true,shadow = true}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                      {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                        {n=G.UIT.T, config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                        {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                        {n=G.UIT.T, config={ref_table = G.GAME.current_round, ref_value = 'reroll_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                      }}
                    }}
                  }}
                }}
end

function ave_check_dunsparce()
    if next(SMODS.find_card("j_poke_dunsparce")) then
        ave_button_red()
    else
        ave_button_green()
    end
end

function ave_button_red()
    Ave_assign_vars()
    G.shop:get_UIE_by_ID('ui_reroll').parent:remove()
    G.shop:add_child(Ave_red,ave_reroll_button)
    Ave_color = G.C.RED
end

function ave_button_green()
    Ave_assign_vars()
    G.shop:get_UIE_by_ID('ui_reroll').parent:remove()
    G.shop:add_child(Ave_green,ave_reroll_button)
    Ave_color = G.C.GREEN
end
