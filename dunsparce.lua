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

--If the player has dunsparce in their deck, then this will change the reroll
--option to be a dunsparce reroll. Otherwise, it'll be a regular reroll. 
function ave_check_dunsparce()

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
            scale = 0.5,
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

	nodes.topModded = {
        n = RectNode,
        config = {
            align = "cm",
            maxw = 1.3
        },
        nodes = { 
			nodes.dunsparce,
			nodes.reroll_text_dunsparce
		 }
    }

	nodes.topVanilla = {
        n = RectNode,
        config = {
            align = "cm",
            maxw = 1.3
        },
        nodes = { 
			nodes.reroll_text
		 }
    }

    
    top = G.shop:get_UIE_by_ID("next_round_button").parent.children[2].children[1].children[1]
	bottom = G.shop:get_UIE_by_ID("next_round_button").parent.children[2].children[1].children[2]

	-- check if the nodes exist, if they don't then the game will crash so we return
	if not top or not bottom then return end

    bottom:remove()
	top:remove()

    G.shop:add_child(dunsparces > 0 and nodes.topModded or nodes.topVanilla, top)
	G.shop:add_child(nodes.bottom, bottom)

	-- Ave_color is used in dunsparce_reroll.toml to change the button color
	-- This is necessary because the reroll button color is updated every frame
	Ave_color = dunsparces > 0 and colors.RED or colors.GREEN
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