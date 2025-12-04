SMODS.Atlas {
  key = "atlas_locations",
  path = "areas.png",
  px = 95,
  py = 71
}

-- Common Stages
SMODS.Stage {
  key = 'viridian_forest',
  loc_txt = {
    name = "Viridian Forest",
    text = {
      "Increased {C:green}Grass{} Pokemon",
      "Common Forest Pokemon",
      "appear more often"
    }
  },
  display_size = {w = 95, h = 71},
  atlas = 'atlas_locations',
  pos = {x=0,y=1},
  rarity = 'ave_common_stages',
  plus_type = {
    {type = 'Grass', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_caterpie', rate = 0.6, rarity = "Common"},
    {key = 'j_poke_metapod', rate = 0.4, rarity = "Common"},
    {key = 'j_poke_butterfree', rate = 0.2, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'dark_cave',
  loc_txt = {
    name = "Dark Cave",
    text = {
      "Increased {C:metal}Metal{} Pokemon",
      "Cave dwellers appear",
      "more frequently"
    }
  },
  display_size = {w = 95, h = 71},
  atlas = 'atlas_locations',
  pos = {x=1,y=1},
  rarity = 'ave_common_stages',
  plus_type = {
    {type = 'Metal', rate = 0.7}
  },
  bonus_key = {
    {key = 'j_poke_sandshrew', rate = 0.5, rarity = "Common"},
    {key = 'j_poke_sandslash', rate = 0.3, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Uncommon Stages
SMODS.Stage {
  key = 'power_plant',
  loc_txt = {
    name = "Abandoned Power Plant",
    text = {
      "Increased {C:yellow}Lightning{} Pokemon",
      "Electric Pokemon appear",
      "{C:green}+1{} Max hand size"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {mod_hand_size = 1}},
  atlas = 'atlas_locations',
  pos = {x=2,y=1},
  rarity = 'ave_uncommon_stages',
  plus_type = {
    {type = 'Lightning', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_pikachu', rate = 0.5, rarity = "Common"},
    {key = 'j_poke_raichu', rate = 0.3, rarity = "Uncommon"},
    {key = 'j_poke_electabuzz', rate = 0.3, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'fighting_dojo',
  loc_txt = {
    name = "Fighting Dojo",
    text = {
      "Increased {C:brown}Fighting{} Pokemon",
      "Fighting specialists train here",
      "{C:green}+5%{} score bonus"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {score_bonus = 1.05}},
  atlas = 'atlas_locations',
  pos = {x=3,y=1},
  rarity = 'ave_uncommon_stages',
  plus_type = {
    {type = 'Fighting', rate = 0.8}
  },
  bonus_key = {
    {key = 'j_poke_hitmonlee', rate = 0.3, rarity = "Uncommon"},
    {key = 'j_poke_hitmonchan', rate = 0.3, rarity = "Uncommon"},
    {key = 'j_poke_hitmontop', rate = 0.3, rarity = "Uncommon"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Rare Stages
SMODS.Stage {
  key = 'dragons_den',
  loc_txt = {
    name = "Dragon's Den",
    text = {
      "Increased {C:orange}Dragon{} Pokemon",
      "Sacred training grounds",
      "{C:green}x1.5{} score multiplier"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {score_mult = 1.5}},
  atlas = 'atlas_locations',
  pos = {x=0,y=2},
  rarity = 'ave_rare_stages',
  plus_type = {
    {type = 'Dragon', rate = 0.9}
  },
  bonus_key = {
    {key = 'j_poke_dratini', rate = 0.5, rarity = "Common"},
    {key = 'j_poke_dragonair', rate = 0.3, rarity = "Uncommon"},
    {key = 'j_poke_dragonite', rate = 0.2, rarity = "Rare"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

SMODS.Stage {
  key = 'team_rocket_hideout',
  loc_txt = {
    name = "Team Rocket Hideout",
    text = {
      "Increased {C:dark}Dark{} Pokemon",
      "Criminal Pokemon lurk here",
      "Double interest gain"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {interest_mult = 2}},
  atlas = 'atlas_locations',
  pos = {x=1,y=2},
  rarity = 'ave_rare_stages',
  plus_type = {
    {type = 'Dark', rate = 0.9}
  },
  bonus_key = {
    {key = 'j_poke_weavile', rate = 0.3, rarity = "Rare"},
    {key = 'j_poke_sneasel', rate = 0.5, rarity = "Common"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Legendary Stages
SMODS.Stage {
  key = 'spear_pillar',
  loc_txt = {
    name = "Spear Pillar",
    text = {
      "{C:metal}Metal{} and {C:orange}Dragon{} boosted",
      "The fabric of space and time",
      "bends to your will"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {all_type_boost = true}},
  atlas = 'atlas_locations',
  pos = {x=0,y=3},
  rarity = 'ave_legendary_stages',
  plus_type = {
    {type = 'Metal', rate = 1},
    {type = 'Dragon', rate = 1}
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
      "{C:dark}Dark{} and {C:orange}Dragon{} boosted",
      "Reality itself is distorted",
      "{C:green}x2{} Legendary rates"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {legendary_mult = 2}},
  atlas = 'atlas_locations',
  pos = {x=1,y=3},
  rarity = 'ave_legendary_stages',
  plus_type = {
    {type = 'Dark', rate = 1},
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

SMODS.Stage {
  key = 'celestic_ruins',
  loc_txt = {
    name = "Celestic Ruins",
    text = {
      "{C:pink}Psychic{} Pokemon boosted",
      "Ancient power flows here",
      "Enhanced everything"
    }
  },
  display_size = {w = 95, h = 71},
  config = {extra = {
    legendary_mult = 1.5,
    score_mult = 1.2,
    card_quality_bonus = 1
  }},
  atlas = 'atlas_locations',
  pos = {x=2,y=3},
  rarity = 'ave_legendary_stages',
  plus_type = {
    {type = 'Psychic', rate = 1}
  },
  bonus_key = {
    {key = 'j_poke_uxie', rate = 0.3, rarity = "Legendary"},
    {key = 'j_poke_mesprit', rate = 0.3, rarity = "Legendary"},
    {key = 'j_poke_azelf', rate = 0.3, rarity = "Legendary"}
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}
