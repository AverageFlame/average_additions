SMODS.Atlas {
  key = "atlas_stages",
  path = "areas.png",
  px = 95,
  py = 71
}

SMODS.ObjectType ({
  key = 'Stage',
  rarities = {
        { key = "ave_common_stages" },
        { key = "ave_uncommon_stages" },
        { key = "ave_rare_stages" },
        { key = "ave_legendary_stages" }
    }
})

SMODS.Stage = SMODS.Center:extend {
    rarity = "ave_common_stages",
    unlocked = true,
    discovered = true,
    pos = {x=0,y=0},
    set = 'Stage',
    atlas = 'atlas_stages',
    class_prefix = 'stage',
    config = {},
    required_params = {
        'key',
    },
    -- fields in plus make jokers with those fields more common by removing jokers that do not match those fields
    plus = {
      -- for making jokers with joker.stage more common, should be nil, "basic", "Stage1" or "Stage2"
      stages = {
        rate = 0,
        stage = {}
      },
      -- if joker does NOT match a value in plus.types.type, it will be removed from the pool based on rate (0 = never, 1 = always)
      types = {
        rate = 0,
        type = {}
      }
    },
    -- fields in minus make jokers with those fields less common by removing them from the pool
    minus = {
      stages = {
        {stage = '', rate = 1}
      },
      -- if joker MATCHES minus.types, it will be removed from the pool based on rate (0 = never, 1 = always)
      types = {
        {type = '', rate = 1}
      }
    },
      -- bonus_key will be added at the end of the pool according to rate (0 = never, 1 = always)
      -- rarity is used to inject into pools that differ from the joker rarity
      -- rate is likelyhood of being added to the pool, it is an additional check on top of being drawn in the shop.
      -- if rarity is nil, it will be added to the pool of the joker rarity
    bonus_key = {
      {key = '', rate = 1, rarity = nil}
    },
    loc_txt = {},
    display_size = {w = 95, h = 71},
    inject = function(self)
        -- call the parent function to ensure all pools are set
        SMODS.Center.inject(self)
        G.P_CENTERS[self.key] = self
        SMODS.insert_pool(G.P_CENTER_POOLS['Stage'], self)
        G.localization.descriptions[self.set] = G.localization.descriptions[self.set] or {}
    end,
    set_card_type_badge = function(self, card, badges)
        local card_type = SMODS.Rarity:get_rarity_badge(card.config.center.rarity)
        local card_type_colour = G.C.RARITY[card.config.center.rarity] or G.C.WHITE
        badges[#badges + 1] = create_badge(card_type, card_type_colour, nil, 1.2)
    end,
    -- this is called when the stage is selected, used for changing game values. make sure to reverse any changes in remove
    modify = function(self)
    end,
    -- this is called when the map is loaded after boss blind is defeated
    remove = function(self)
    end
}

G.stage_undiscovered = {unlocked = false, max = 1, name = "Locked", pos = {x=4,y=0}, set = "Stage", cost_mult = 1.0,config = {}}
SMODS.UndiscoveredSprite { key = 'Stage', set = 'Stage', atlas = 'ave_atlas_stages', pos = G.stage_undiscovered.pos, display_size = {w = 95, h = 71} }
--Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["ave_atlas_stages"], G.stage_undiscovered.pos)


SMODS.Rarity {
  key = 'common_stages',
  badge_colour = G.C.RARITY[1],
  default_weight = 0.62,
  pools = {
    ["Stage"] = true
  }
}

SMODS.Rarity {
  key = 'uncommon_stages',
  badge_colour = G.C.RARITY[2],
  default_weight = 0.25,
  pools = {
    ["Stage"] = true
  },
  get_weight = function(self, weight, object_type)
      return weight
  end
}

SMODS.Rarity {
  key = 'rare_stages',
  badge_colour = G.C.RARITY[3],
  default_weight = 0.09,
  pools = {
    ["Stage"] = true
  },
  get_weight = function(self, weight, object_type)
      return weight
  end
}

SMODS.Rarity {
  key = 'legendary_stages',
  badge_colour = HEX("F2C74E"),
  default_weight = 0.03,
  pools = {
    ["Stage"] = true
  },
  get_weight = function(self, weight, object_type)
      return weight
  end
}

SMODS.Stage {
  key = 'undiscovered',
  loc_txt = {
    name = "Undiscovered",
    text = {
      "test"
    }
  },
  display_size = {w = 95, h = 71},

  atlas = 'atlas_stages',
  pos = {x=4,y=0},
  pools = {
    ["Stage"] = false
  },
  in_pool = function(self, args)
    return false
  end
}

AVE.BG = {}
AVE.BG.atlas = 'atlas_stages'
AVE.BG.common = {x=0,y=0}
AVE.BG.uncommon = {x=1,y=0}
AVE.BG.rare = {x=2,y=0}
AVE.BG.legend = {x=3,y=0}
AVE.BG.undiscovered = {x=4,y=0}
AVE.BG.ilex_forest = {x=5,y=0}
AVE.BG.viridian_forest = {x=6,y=0}
AVE.BG.victory_road = {x=7,y=0}
AVE.BG.diglett_cave = {x=8,y=0}
AVE.BG.mt_moon = {x=0,y=1}
AVE.BG.cerulean_cave = {x=1,y=1}
AVE.BG.rock_tunnel = {x=2,y=1}
AVE.BG.power_plant = {x=3,y=1}
AVE.BG.pokemon_tower = {x=4,y=1}
AVE.BG.rocket_hideout = {x=5,y=1}
AVE.BG.safari_zone = {x=6,y=1}
AVE.BG.silph_co = {x=7,y=1}
AVE.BG.seafoam = {x=8,y=1}
AVE.BG.mansion = {x=0,y=2}
AVE.BG.mt_ember = {x=1,y=2}
AVE.BG.berry_forest = {x=2,y=2}
AVE.BG.icefall_cave = {x=3,y=2}
AVE.BG.rocket_warehouse = {x=4,y=2}
AVE.BG.lost_cave = {x=5,y=2}
AVE.BG.altering_cave = {x=6,y=2}
AVE.BG.dotted_hole = {x=7,y=2}
AVE.BG.tanoby = {x=8,y=2}
AVE.BG.sprout_tower = {x=0,y=3}
AVE.BG.dark_cave = {x=1,y=3}
AVE.BG.alph_ruins = {x=2,y=3}
AVE.BG.union_cave = {x=3,y=3}
AVE.BG.slowpoke_well = {x=4,y=3}
AVE.BG.national_park = {x=5,y=3}
AVE.BG.burned_tower = {x=6,y=3}
AVE.BG.bell_tower = {x=7,y=3}
AVE.BG.whirl_islands = {x=8,y=3}
AVE.BG.mt_mortar = {x=0,y=4}
AVE.BG.ice_path = {x=1,y=4}
AVE.BG.dragons_den = {x=2,y=4}
AVE.BG.mt_silver = {x=3,y=4}
AVE.BG.tohjo_falls = {x=4,y=4}
AVE.BG.hgss_victory_road = {x=5,y=4}
AVE.BG.hgss_viridian_forest = {x=6,y=4}
AVE.BG.hgss_diglett_cave = {x=7,y=4}
AVE.BG.hgss_mt_moon = {x=8,y=4}
AVE.BG.hgss_cerulean_cave = {x=0,y=5}
AVE.BG.hgss_rock_tunnel = {x=1,y=5}
AVE.BG.hgss_seafoam = {x=2,y=5}

local safari_color = HEX("F2C74E")


-- ptype_list = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", 
-- "Metal", "Fairy", "Dragon", "Earth"}
---------------------------------------------------------------------------
---                            COMMON STAGES                            ---             
---------------------------------------------------------------------------

local common_rate = 0.4
-- Viridian forest - Grass
SMODS.Stage {
  key = 'viridian_forest',
  loc_txt = {
    name = "Viridian Forest",
    text = {
      "{X:green,C:white}Grass{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.viridian_forest,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Grass'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Mt ember - Fire
SMODS.Stage {
  key = 'mt_mortar',
  loc_txt = {
    name = "Mt. Mortar",
    text = {
      "{X:red,C:white}Fire{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.mt_mortar,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Fire'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- seafoam islands - Water
SMODS.Stage {
  key = 'slowpoke_well',
  loc_txt = {
    name = "Slowpoke Well",
    text = {
      "{X:blue,C:white}Water{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.slowpoke_well,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Water'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Power plant - Lightning
SMODS.Stage {
  key = 'rocket_warehouse',
  loc_txt = {
    name = "Rocket Warehouse",
    text = {
      "{X:money,C:white}Lightning{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.rocket_warehouse,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Lightning'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- pokemon tower - Psychic
SMODS.Stage {
  key = 'pokemon_tower',
  loc_txt = {
    name = "Pokemon Tower",
    text = {
      "{X:purple,C:white}Psychic{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.pokemon_tower,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Psychic'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Sprout tower - Fighting
SMODS.Stage {
  key = 'sprout_tower',
  loc_txt = {
    name = "Sprout Tower",
    text = {
      "{X:orange,C:white}Fighting{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.sprout_tower,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Fighting'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- union cave - Colorless
SMODS.Stage {
  key = 'union_cave',
  loc_txt = {
    name = "Union Cave",
    text = {
      "{X:dark_edition,C:white}Colorless{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.union_cave,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Colorless'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- rocket_hideout - Dark
SMODS.Stage {
  key = 'rocket_hideout',
  loc_txt = {
    name = "Rocket Hideout",
    text = {
      "{X:black,C:white}Dark{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.rocket_hideout,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Dark'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- mt silver - Metal
SMODS.Stage {
  key = 'mt_silver',
  loc_txt = {
    name = "Mt. Silver",
    text = {
      "{X:grey,C:white}Metal{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.mt_silver,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Metal'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- berry forest - Fairy
SMODS.Stage {
  key = 'berry_forest',
  loc_txt = {
    name = "Berry Forest",
    text = {
      "{X:pink,C:white}Fairy{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.berry_forest,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Fairy'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- dragons den - Dragon
SMODS.Stage {
  key = 'dragons_den',
  loc_txt = {
    name = "Dragon's Den",
    text = {
      "{X:blue,C:white}Dragon{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.dragons_den,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Dragon'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- rock tunnel - Earth
SMODS.Stage {
  key = 'rock_tunnel',
  loc_txt = {
    name = "Rock Tunnel",
    text = {
      "{X:brown,C:white}Earth{} Pokemon are",
      "slightly more common",
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.rock_tunnel,
  rarity = 'ave_common_stages',
  plus = {
    types = {
      rate = common_rate,
      type = {'Earth'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

---------------------------------------------------------------------------
---                           UNCOMMON STAGES                           ---             
---------------------------------------------------------------------------

local uncommon_rate = 0.7

-- Mt. Moon - Earth/Psychic dual type
SMODS.Stage {
  key = 'mt_moon',
  loc_txt = {
    name = "Mt. Moon",
    text = {
      "{X:brown,C:white}Earth{} and {X:purple,C:white}Psychic{}",
      "Pokemon are more common",
      "{X:red,C:white}Fire{} Pokemon are less common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.mt_moon,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Earth', 'Psychic'}
    }
  },
  minus = {
    types = {
      {type = 'Fire', rate = 0.3}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Cerulean Cave - Water/Psychic dual type
SMODS.Stage {
  key = 'cerulean_cave',
  loc_txt = {
    name = "Cerulean Cave",
    text = {
      "{X:blue,C:white}Water{} and {X:purple,C:white}Psychic{}",
      "Pokemon are more common",
      "{X:orange,C:white}Fighting{} Pokemon are less common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.hgss_cerulean_cave,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Water', 'Psychic'}
    }
  },
  minus = {
    types = {
      {type = 'Fighting', rate = 0.4}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Safari Zone - Colorless focused with variety
SMODS.Stage {
  key = 'safari_zone',
  loc_txt = {
    name = "Safari Zone",
    text = {
      "{X:dark_edition,C:white}Colorless{}, {X:green,C:white}Grass{} and",
      "{X:blue,C:white}Water{} Pokemon are more common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.safari_zone,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Colorless', 'Grass', 'Water'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Burned Tower - Fire/Dark dual type
SMODS.Stage {
  key = 'pokemon_mansion',
  loc_txt = {
    name = "Pokemon Mansion",
    text = {
      "{X:red,C:white}Fire{} and {X:black,C:white}Dark{}",
      "Pokemon are more common",
      "{X:blue,C:white}Water{} Pokemon are less common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.mansion,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Fire', 'Dark'}
    }
  },
  minus = {
    types = {
      {type = 'Water', rate = 0.5}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- Ice Path - Water/Metal dual type
SMODS.Stage {
  key = 'ice_path',
  loc_txt = {
    name = "Ice Path",
    text = {
      "{X:blue,C:white}Water{} and {X:grey,C:white}Metal{}",
      "Pokemon are more common",
      "{X:red,C:white}Fire{} and {X:green,C:white}Grass{} are less common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.ice_path,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Water', 'Metal'}
    }
  },
  minus = {
    types = {
      {type = 'Fire', rate = 0.6},
      {type = 'Grass', rate = 0.4}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

-- National Park - Grass/Fairy dual type
SMODS.Stage {
  key = 'national_park',
  loc_txt = {
    name = "National Park",
    text = {
      "{X:green,C:white}Grass{} and {X:pink,C:white}Fairy{}",
      "Pokemon are more common",
      "{X:black,C:white}Dark{} Pokemon are less common"
    }
  },
  atlas = 'atlas_stages',
  pos = AVE.BG.national_park,
  rarity = 'ave_uncommon_stages',
  plus = {
    types = {
      rate = uncommon_rate,
      type = {'Grass', 'Fairy'}
    }
  },
  minus = {
    types = {
      {type = 'Dark', rate = 0.7}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end
}

---------------------------------------------------------------------------
---                            RARE STAGES                             ---             
---------------------------------------------------------------------------

-- Victory Road - Fighting exclusive
SMODS.Stage {
  key = 'victory_road',
  loc_txt = {
    name = "Victory Road",
    text = {
      "Only {X:orange,C:white}Fighting{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.victory_road,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Fighting'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Bell Tower - Psychic exclusive
SMODS.Stage {
  key = 'ruins_of_alph',
  loc_txt = {
    name = "Ruins of Alph",
    text = {
      "Only {X:purple,C:white}Psychic{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.alph_ruins,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Psychic'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Whirl Islands - Water exclusive
SMODS.Stage {
  key = 'seafoam_islands_rare',
  loc_txt = {
    name = "Seafoam Islands",
    text = {
      "Only {X:blue,C:white}Water{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.hgss_seafoam,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Water'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Silph Co - Lightning exclusive
SMODS.Stage {
  key = 'silph_co',
  loc_txt = {
    name = "Silph Co.",
    text = {
      "Only {X:money,C:white}Lightning{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.silph_co,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Lightning'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Diglett Cave - Earth exclusive
SMODS.Stage {
  key = 'diglett_cave',
  loc_txt = {
    name = "Diglett Cave",
    text = {
      "Only {X:brown,C:white}Earth{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.diglett_cave,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Earth'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Dark Cave - Dark exclusive
SMODS.Stage {
  key = 'dark_cave',
  loc_txt = {
    name = "Dark Cave",
    text = {
      "Only {X:black,C:white}Dark{} Pokemon",
      "can be found",
      "Small chance for {V:1}Safari{} Pokemon"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.dark_cave,
  rarity = 'ave_rare_stages',
  plus = {
    types = {
      rate = 1,
      type = {'Dark'}
    }
  },
  pools = { ["Stage"] = true },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0.1
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}


local legendary_rate = 1
SMODS.Stage {
  key = 'ilex_forest',
  loc_txt = {
    name = "Ilex Forest",
    text = {
      "Only {X:green,C:white}Grass{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Celebi{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.ilex_forest,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Grass'}
    }
  },
  bonus_key = {
    {key = 'j_poke_celebi', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Power Plant - Zapdos legendary stage
SMODS.Stage {
  key = 'power_plant_legendary',
  loc_txt = {
    name = "Power Plant (Legendary)",
    text = {
      "Only {X:money,C:white}Lightning{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Zapdos{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.power_plant,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Lightning'}
    }
  },
  bonus_key = {
    {key = 'j_poke_zapdos', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Seafoam Islands - Articuno legendary stage
SMODS.Stage {
  key = 'seafoam_legendary',
  loc_txt = {
    name = "Seafoam Islands (Legendary)",
    text = {
      "Only {X:blue,C:white}Water{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Articuno{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.seafoam,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Water'}
    }
  },
  bonus_key = {
    {key = 'j_poke_articuno', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Mt. Ember - Moltres legendary stage
SMODS.Stage {
  key = 'mt_ember_legendary',
  loc_txt = {
    name = "Mt. Ember (Legendary)",
    text = {
      "Only {X:red,C:white}Fire{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Moltres{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.mt_ember,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Fire'}
    }
  },
  bonus_key = {
    {key = 'j_poke_moltres', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Cerulean Cave - Mewtwo legendary stage
SMODS.Stage {
  key = 'cerulean_cave_legendary',
  loc_txt = {
    name = "Cerulean Cave (Legendary)",
    text = {
      "Only {X:purple,C:white}Psychic{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Mewtwo{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.cerulean_cave,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Psychic'}
    }
  },
  bonus_key = {
    {key = 'j_poke_mewtwo', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Burned Tower - Entei legendary stage
SMODS.Stage {
  key = 'burned_tower_legendary',
  loc_txt = {
    name = "Burned Tower (Legendary)",
    text = {
      "Only {X:red,C:white}Fire{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Entei{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.burned_tower,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Fire'}
    }
  },
  bonus_key = {
    {key = 'j_poke_entei', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Whirl Islands - Lugia legendary stage
SMODS.Stage {
  key = 'whirl_islands_legendary',
  loc_txt = {
    name = "Whirl Islands (Legendary)",
    text = {
      "Only {X:purple,C:white}Psychic{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Lugia{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.whirl_islands,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Psychic'}
    }
  },
  bonus_key = {
    {key = 'j_poke_lugia', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}

-- Bell Tower - Ho-Oh legendary stage
SMODS.Stage {
  key = 'bell_tower_legendary',
  loc_txt = {
    name = "Bell Tower (Legendary)",
    text = {
      "Only {X:red,C:white}Fire{} {V:1}Safari",
      "Pokemon can be found",
      "Rare chance for ",
      "{E:1,C:legendary}Ho-Oh{} to appear"
    }
  },
  loc_vars = { colours = {safari_color}},
  atlas = 'atlas_stages',
  pos = AVE.BG.bell_tower,
  rarity = 'ave_legendary_stages',
  pools = {
    ["Stage"] = true
  },
  plus = {
    types = {
      rate = legendary_rate,
      type = {'Fire'}
    }
  },
  bonus_key = {
    {key = 'j_poke_ho_oh', rate = 0.1, rarity = "poke_safari"},
  },
  in_pool = function(self, args)
    return true, {allow_duplicates = true}
  end,
  modify = function(self)
    AVE.rarity_weights = {}
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      AVE.rarity_weights[i] = SMODS.ObjectTypes.Joker.rarities[i].weight
      if SMODS.ObjectTypes.Joker.rarities[i].key == "poke_safari" then
        SMODS.ObjectTypes.Joker.rarities[i].weight = 1
      else
        SMODS.ObjectTypes.Joker.rarities[i].weight = 0
      end
    end
  end,
  remove = function(self)
    for i = 1, #SMODS.ObjectTypes.Joker.rarities do
      SMODS.ObjectTypes.Joker.rarities[i].weight = AVE.rarity_weights[i]
    end
    AVE.rarity_weights = {}
  end
}