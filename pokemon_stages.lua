-- Common Stages (Type focus only)
SMODS.Stage {
  key = 'viridian_forest',
  loc_txt = {
    name = "Viridian Forest",
    text = {
      "Increased {C:green}Bug{} Pokemon",
      "Common Caterpie and Weedle",
      "appear more often"
    }
  },
  display_size = {w = 95, h = 71},
  atlas = 'atlas_stages',
  pos = {x=0,y=1},
  rarity = 'ave_common_stages',
  plus_type = {
    {type = 'Bug', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_caterpie', rate = 0.6, rarity = "Common"},
    {key = 'j_poke_weedle', rate = 0.6, rarity = "Common"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'mt_moon',
  loc_txt = {
    name = "Mt. Moon",
    text = {
      "Increased {C:purple}Rock{} Pokemon",
      "Chance for Zubat to appear",
      "in the pool"
    }
  },
  display_size = {w = 95, h = 71},
  atlas = 'atlas_stages',
  pos = {x=1,y=1},
  rarity = 'ave_common_stages',
  plus_type = {
    {type = 'Rock', rate = 0.7}
  },
  bonus_key = {
    {key = 'j_poke_zubat', rate = 0.5, rarity = "Common"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Uncommon Stages (Type focus + minor benefits)
SMODS.Stage {
  key = 'power_plant',
  loc_txt = {
    name = "Abandoned Power Plant",
    text = {
      "Increased {C:yellow}Electric{} Pokemon",
      "Chance for {C:yellow}Electabuzz{},",
      "{C:green}+1{} Max hand size"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {mod_hand_size = 1}},
  atlas = 'atlas_stages',
  pos = {x=2,y=1},
  rarity = 'ave_uncommon_stages',
  plus_type = {
    {type = 'Electric', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_electabuzz', rate = 0.4, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'safari_zone',
  loc_txt = {
    name = "Safari Zone",
    text = {
      "Increased {C:brown}Normal{} Pokemon",
      "Chance for {C:brown}Tauros{},",
      "{C:green}+5{} max interest"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {mod_max_interest = 5}},
  atlas = 'atlas_stages',
  pos = {x=3,y=1},
  rarity = 'ave_uncommon_stages',
  plus_type = {
    {type = 'Normal', rate = 0.7}
  },
  bonus_key = {
    {key = 'j_poke_tauros', rate = 0.4, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Rare Stages (Significant benefits + strong Pokemon)
SMODS.Stage {
  key = 'dragons_den',
  loc_txt = {
    name = "Dragon's Den",
    text = {
      "Increased {C:orange}Dragon{} Pokemon",
      "Chance for {C:orange}Dragonite{},",
      "{C:green}x1.5{} score multiplier"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {score_mult = 1.5}},
  atlas = 'atlas_stages',
  pos = {x=0,y=2},
  rarity = 'ave_rare_stages',
  plus_type = {
    {type = 'Dragon', rate = 0.9}
  },
  bonus_key = {
    {key = 'j_poke_dragonite', rate = 0.3, rarity = "Rare"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'cinnabar_lab',
  loc_txt = {
    name = "Cinnabar Lab",
    text = {
      "Increased {C:pink}Psychic{} Pokemon",
      "Rare chance for {C:pink}Mewtwo{},",
      "{C:green}Enhanced{} card choices"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {card_quality_bonus = 2}},
  atlas = 'atlas_stages',
  pos = {x=1,y=2},
  rarity = 'ave_rare_stages',
  plus_type = {
    {type = 'Psychic', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_mewtwo', rate = 0.2, rarity = "Rare"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Legendary Stages (Major benefits + legendary Pokemon)
SMODS.Stage {
  key = 'spear_pillar',
  loc_txt = {
    name = "Spear Pillar",
    text = {
      "All Pokemon types boosted",
      "Chance for {C:legendary}Dialga{},",
      "or {C:legendary}Palkia{}"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {all_type_boost = true}},
  atlas = 'atlas_stages',
  pos = {x=0,y=3},
  rarity = 'ave_legendary_stages',
  plus_type = {
    {type = 'Dragon', rate = 1},
    {type = 'Steel', rate = 1}
  },
  bonus_key = {
    {key = 'j_poke_dialga', rate = 0.3, rarity = "Legendary"},
    {key = 'j_poke_palkia', rate = 0.3, rarity = "Legendary"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'distortion_world',
  loc_txt = {
    name = "Distortion World",
    text = {
      "All card values randomized",
      "Chance for {C:legendary}Giratina{},",
      "{C:green}x2{} Legendary rates"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {cards_random = true, legendary_mult = 2}},
  atlas = 'atlas_stages',
  pos = {x=1,y=3},
  rarity = 'ave_legendary_stages',
  plus_type = {
    {type = 'Ghost', rate = 1},
    {type = 'Dragon', rate = 1}
  },
  bonus_key = {
    {key = 'j_poke_giratina', rate = 0.4, rarity = "Legendary"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}
