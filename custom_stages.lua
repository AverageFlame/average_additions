SMODS.Atlas {
  key = "atlas_custom_stages",
  path = "custom_areas.png",
  px = 95,
  py = 71
}

SMODS.Stage {
  key = 'casino_floor',
  loc_txt = {
    name = "Casino Floor",
    text = {
      "Increased chance of {C:red}Face Cards{}",
      "Shop prices increased by {C:red}25%{}",
      "Interest cap raised to {C:green}$30{}"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {mod_max_interest = 30, shop_price_mult = 1.25}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mod_max_interest, card.ability.extra.shop_price_mult * 100 } }
  end,
  atlas = 'atlas_custom_stages',
  pos = {x=0,y=0},
  rarity = 'ave_common_stages',
  pools = {
    ["Stage"] = true
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'misty_lake',
  loc_txt = {
    name = "Misty Lake",
    text = {
      "All {C:blue}Spades{} are doubled",
      "but {C:red}Hearts{} are halved",
      "{C:green}+2{} hand size"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {mod_hand_size = 2, spade_mult = 2, heart_mult = 0.5}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mod_hand_size, card.ability.extra.spade_mult, card.ability.extra.heart_mult } }
  end,
  atlas = 'atlas_custom_stages',
  pos = {x=1,y=0},
  rarity = 'ave_uncommon_stages',
  pools = {
    ["Stage"] = true
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'ancient_temple',
  loc_txt = {
    name = "Ancient Temple",
    text = {
      "Jokers cost {C:red}2x{} more",
      "but give {C:green}2x{} their effect",
      "{C:red}-1{} starting hand size"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {joker_price_mult = 2, joker_effect_mult = 2, mod_hand_size = -1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.joker_price_mult, card.ability.extra.joker_effect_mult, card.ability.extra.mod_hand_size } }
  end,
  atlas = 'atlas_custom_stages',
  pos = {x=2,y=0},
  rarity = 'ave_rare_stages',
  pools = {
    ["Stage"] = true
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'quantum_realm',
  loc_txt = {
    name = "Quantum Realm",
    text = {
      "All cards are wild",
      "But score is {C:red}halved{}",
      "Legendary Jokers are {C:green}2x{} more common"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {cards_wild = true, score_mult = 0.5}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.score_mult * 100 } }
  end,
  atlas = 'atlas_custom_stages',
  pos = {x=3,y=0},
  rarity = 'ave_legendary_stages',
  bonus_key = {
    {key = 'j_golden', rate = 1, rarity = "Legendary"},
    {key = 'j_stone', rate = 1, rarity = "Legendary"}
  },
  pools = {
    ["Stage"] = true
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}
