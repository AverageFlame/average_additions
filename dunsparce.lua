local TextNode, RectNode, ObjectNode
local colors, dunsparces

--Creating variables both makes it easier to understand (since
--localthunk is afraid of words) and is a microoptimization,
--since we are reducing table lookups.
--NOTE: Type of node is merely being inferred, and may actually
--not be correct. Double check when implementing.
TextNode   = G.UIT.T
RectNode   = G.UIT.R
ObjectNode = G.UIT.O

colors = G.C

Ave_color = colors.GREEN
Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])

dunsparces = 0

--Creates either the red button or green button. Pass in the color, and
--the nodes that go on the top part. The bottom is always the reroll cost.
function createButton(color, ...)
    local nodes = {}

    nodes.dollar_sign = {
        n = TextNode,
        config = {
            text = localize("$"),
            scale = 0.7,
            colour = colors.WHITE,
            shadow = true
        }
    }

    nodes.reroll_cost = {
        n = TextNode,
        config = {
            scale = 0.75,
            colour = colors.WHITE,
            shadow = true,
            ref_value = "reroll_cost",
            ref_table = G.GAME.current_round
        }
    }

    --Contains both reroll cost and the money sign (does
    --localize change the dollar sign into that languages money
    --sign? Pretty cool if so.)
    nodes.bottom = {
        n = RectNode,
        config = {
            maxw = 1.3,
            minw = 1,
            align = "cm"
        },
        nodes = {
            nodes.dollar_sign,
            nodes.reroll_cost
        }
    }

    --Contains the top portion of text.
    nodes.top = {
        n = RectNode,
        config = {
            align = "cm",
            maxw = 1.3
        },
        nodes = { ... }
    }

    return {
        n = RectNode,
        config = { align = "cm" },
        nodes = {
            {
                n = RectNode,
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
                    colour = color
                },
                nodes = {
                    {
                        n = RectNode,
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
                            nodes.top,
                            nodes.bottom
                        }
                    }
                }
            }
        }
    }
end

--If the player has dunsparce in their deck, then this will change the reroll
--option to be a dunsparce reroll. Otherwise, it'll be a regular reroll. 
function ave_check_dunsparce()
    local red, green, reroll_button, nodes

    Dunsparce = Sprite(0,0, 0.5, 0.5, G.ASSET_ATLAS["angry-dunsparce"])

	local nodes = {}

    nodes.dunsparce = {
        n = ObjectNode,
        config = { object = Dunsparce }
    }

    --Modded. "Reroll?"
    nodes.reroll_text_dunsparce = {
        n = TextNode,
        config = {
            text = localize("ave_reroll"),
            scale = 1.5,
            colour = colors.WHITE,
            shadow = true
        }
    }
    
    --Vanilla. "Reroll"
    nodes.reroll_text = {
        n = TextNode,
        config = {
            text = localize("k_reroll"),
            scale = 0.4,
            colour = colors.WHITE,
            shadow = true
        }
    }

    red   = createButton(colors.RED, nodes.dunsparce, nodes.reroll_text_dunsparce)
    green = createButton(colors.GREEN, nodes.reroll_text)
    
    reroll_button = G.shop:get_UIE_by_ID("next_round_button").parent.parent.children[2]

    reroll_button:remove()

    G.shop:add_child(dunsparces > 0 and red or green, reroll_button)
end

--Keep track of dunsparces in deck. Prevents race conditions with `find_in_deck`.
--To be used as a callback function.
function addDunsparceToDeck()
	dunsparces = dunsparces + 1

    if G.STATE ~= G.STATES.SHOP then return end

    ave_check_dunsparce()
end

function removeDunsparceFromDeck()
	dunsparces = dunsparces - 1

    if G.STATE ~= G.STATES.SHOP then return end

    ave_check_dunsparce()
end