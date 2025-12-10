local TextNode, RootNode, ObjectNode
local colors

--Creating variables both makes it easier to understand (since
--localthunk is afraid of words) and is a microoptimization,
--since we are reducing table lookups.
--NOTE: Type of node is merely being inferred, and may actually
--not be correct. Double check when implementing.
TextNode   = G.UIT.T
RootNode   = G.UIT.R --Possibly RectNode?
ObjectNode = G.UIT.O

colors = G.C

Ave_color = colors.GREEN
Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])

function Ave_assign_vars()
    Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])

    return {
        n = RootNode,
        config = { align = "cm" },
        nodes = {
            {
                n = RootNode,
                config = {
                    id = "ui_reroll",
                    func = "can_reroll",
                    align = "cm",
                    button = "reroll_shop",
                    r = 0.15,
                    minw = 2.8,
                    minh = 1.6,
                    hover = true,
                    shadow = true,
                    colour = colors.GREEN
                },
                nodes = {
                    {
                        n = RootNode,
                        config = {
                            align = "cm",
                            func = "set_button_pip",
                            padding = 0.07,
                            focus_args = {
                                button = "x",
                                orientation = "cr"
                            },
                        },
                        nodes = {
                            {
                                n = RootNode,
                                config = {
                                    maxw = 1.3,
                                    align = "cm",
                                },
                                nodes = {
                                    {
                                        n = ObjectNode,
                                        config = { object = Dunsparce }
                                    },
                                    {
                                        n = TextNode,
                                        config = {
                                            text = localize("ave_reroll"),
                                            scale = 1.5,
                                            colour = colors.WHITE,
                                            shadow = true
                                        }
                                    }
                                }
                            },
                            {
                                n = RootNode,
                                config = {
                                    maxw = 1.3,
                                    minw = 1,
                                    align = "cm"
                                },
                                nodes = {
                                    {
                                        n = TextNode,
                                        config = {
                                            text = localize("$"),
                                            scale = 0.7,
                                            colour = colors.WHITE,
                                            shadow = true
                                        }
                                    },
                                    {
                                        n = TextNode,
                                        config = {
                                            scale = 0.75,
                                            colour = colors.WHITE,
                                            shadow = true,
                                            ref_value = "reroll_cost",
                                            ref_table = G.GAME.current_round
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    {
        n = RootNode,
        config = { align = "cm" },
        nodes = {
            {
                n = RootNode,
                config = {
                    id = "ui_reroll",
                    func = "can_reroll",
                    align = "cm",
                    button = "reroll_shop",
                    r = 0.15,
                    minw = 2.8,
                    minh = 1.6,
                    hover = true,
                    shadow = true,
                    colour = colors.GREEN
                },
                nodes = {
                    {
                        n = RootNode,
                        config = {
                            align = "cm",
                            func = "set_button_pip",
                            padding = 0.07,
                            focus_args = {
                                button = "x",
                                orientation = "cr"
                            },
                        },
                        nodes = {
                            {
                                n = RootNode,
                                config = {
                                    align = "cm",
                                    maxw = 1.3
                                },
                                nodes = {
                                    {
                                        n = TextNode,
                                        config = {
                                            text = localize("k_reroll"),
                                            scale = 0.4,
                                            colour = colors.WHITE,
                                            shadow = true
                                        }
                                    }
                                }
                            },
                            {
                                n = RootNode,
                                config = {
                                    maxw = 1.3,
                                    minw = 1,
                                    align = "cm"
                                },
                                nodes = {
                                    {
                                        n = TextNode,
                                        config = {
                                            text = localize("$"),
                                            scale = 0.7,
                                            colour = colors.WHITE,
                                            shadow = true
                                        }
                                    },
                                    {
                                        n = TextNode,
                                        config = {
                                            scale = 0.75,
                                            colour = colors.WHITE,
                                            shadow = true,
                                            ref_table = G.GAME.current_round,
                                            ref_value = "reroll_cost"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }, G.shop:get_UIE_by_ID("ui_reroll").parent
end

function ave_check_dunsparce()
    if next(SMODS.find_card("j_poke_dunsparce")) then
        ave_button_red()
    else
        ave_button_green()
    end
end

function ave_button_red()
    local red, _, reroll_button = Ave_assign_vars()
    G.shop:get_UIE_by_ID("ui_reroll").parent:remove()
    G.shop:add_child(red, reroll_button)
    Ave_color = colors.RED
end

function ave_button_green()
    local _, green, reroll_button = Ave_assign_vars()
    G.shop:get_UIE_by_ID("ui_reroll").parent:remove()
    G.shop:add_child(green, reroll_button)
    Ave_color = colors.GREEN
end
