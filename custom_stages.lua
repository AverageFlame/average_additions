local WIDTH, HEIGHT

WIDTH  = 95
HEIGHT = 71

local function pool()
    return true, { allow_duplicates = true }
end

SMODS.Atlas {
  px = WIDTH,
  py = HEIGHT,
  key = "atlas_custom_stages",
  path = "custom_areas.png",
}

SMODS.Stage {
  key = "casino_floor",
  atlas = "atlas_custom_stages",
  rarity = "ave_common_stages",
  pos = {
    x = 0,
    y = 0
  },
  pools = {
    Stage = true
  },
  config = {
    extra = {
      mod_max_interest = 30,
      shop_price_mult = 1.25
    }
  },
  loc_txt = {
    name = "Casino Floor",
    text = {
      "Increased chance of {C:red}Face Cards{}",
      "Shop prices increased by {C:red}25%{}",
      "Interest cap raised to {C:green}$30{}"
    }
  },
  display_size = {
    w = WIDTH,
    h = HEIGHT
  },
  loc_vars = function(_, _, card)
    local extra = card.ability.extra

    return {
      vars = {
        extra.mod_max_interest,
        extra.shop_price_mult * 100
      }
    }
  end,
  in_pool = pool
}

SMODS.Stage {
  key = "misty_lake",
  atlas = "atlas_custom_stages",
  rarity = "ave_uncommon_stages",
  pos = {
    x = 1,
    y = 0
  },
  pools = {
    Stage = true
  },
  config = {
    extra = {
      mod_hand_size = 2,
      spade_mult = 2,
      heart_mult = 0.5
    }
  },
  loc_txt = {
    name = "Misty Lake",
    text = {
      "All {C:blue}Spades{} are doubled",
      "but {C:red}Hearts{} are halved",
      "{C:green}+2{} hand size"
    }
  },
  display_size = {
    w = WIDTH,
    h = HEIGHT
  },
  loc_vars = function(_, _, card)
    local extra = card.ability.extra

    return {
      vars = {
        extra.mod_hand_size,
        extra.spade_mult,
        extra.heart_mult
      }
    }
  end,
  in_pool = pool
}

SMODS.Stage {
  key = "ancient_temple",
  atlas = "atlas_custom_stages",
  rarity = "ave_rare_stages",
  pos = {
    x = 2,
    y = 0
  },
  pools = {
    Stage = true
  },
  config = {
    extra = {
      joker_price_mult = 2,
      joker_effect_mult = 2,
      mod_hand_size = -1
    }
  },
  loc_txt = {
    name = "Ancient Temple",
    text = {
      "Jokers cost {C:red}2x{} more",
      "but give {C:green}2x{} their effect",
      "{C:red}-1{} starting hand size"
    }
  },
  display_size = {
    w = WIDTH,
    h = HEIGHT
  },
  loc_vars = function(_, _, card)
    local extra = card.ability.extra
    
    return {
      vars = {
        extra.joker_price_mult,
        extra.joker_effect_mult,
        extra.mod_hand_size
      }
    }
  end,
  in_pool = pool
}

SMODS.Stage {
  key = "quantum_realm",
  atlas = "atlas_custom_stages",
  rarity = "ave_legendary_stages",
  pos = {
    x = 3,
    y = 0
  },
  pools = {
    Stage = true
  },
  config = {
    extra = {
      cards_wild = true,
      score_mult = 0.5
    }
  },
  loc_txt = {
    name = "Quantum Realm",
    text = {
      "All cards are wild",
      "But score is {C:red}halved{}",
      "Legendary Jokers are {C:green}2x{} more common"
    }
  },
  bonus_key = {
    { key = "j_golden", rate = 1, rarity = "Legendary" },
    { key = "j_stone",  rate = 1, rarity = "Legendary" }
  },
  display_size = {
    w = WIDTH,
    h = HEIGHT
  },
  loc_vars = function(_, _, card)
    return {
      vars = {
        card.ability.extra.score_mult * 100
      }
    }
  end,
  in_pool = pool
}
