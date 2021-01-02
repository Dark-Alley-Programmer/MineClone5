local S = minetest.get_translator("mcl_tools")

-- mods/default/tools.lua

--
-- Tool definition
--

--[[ Maximum drop level definitions:
- 0: Hand
- 1: Wood / Shears
- 2: Gold
- 3: Stone
- 4: Iron
- 5: Diamond

dig_speed_class group:
- 1: Painfully slow
- 2: Very slow
- 3: Slow
- 4: Fast
- 5: Very fast
- 6: Extremely fast
- 7: Instantaneous
]]

-- The hand
local groupcaps, hand_range, hand_groups
if minetest.is_creative_enabled("") then
	-- Instant breaking in creative mode
	groupcaps = {
		creative_breakable = {times={[1]=0}, uses=0},
	}
	-- mcl_autogroup provides the creative digging times for all digging groups
	for k,v in pairs(mcl_autogroup.creativetimes) do
		groupcaps[k] = { times = v, uses = 0 }
	end
	hand_range = 10
	hand_groups = { dig_speed_class = 7 }
else
	groupcaps = {
		handy_dig = {times=mcl_autogroup.digtimes.handy_dig, uses=0},
	}
	hand_range = 4
	hand_groups = { dig_speed_class = 1 }
end
minetest.register_item(":", {
	type = "none",
	_doc_items_longdesc = S("You use your bare hand whenever you are not wielding any item. With your hand you can mine most blocks, but this is the slowest method and only the weakest blocks will yield their useful drop. The hand also deals minor damage by punching. Using the hand is often a last resort, as proper mining tools and weapons are much better.").."\n"..
			S("When you are wielding an item which is not a mining tool or a weapon, it will behave as if it were the hand when you start mining or punching.").."\n"..
			S("In Creative Mode, the hand is able to break all blocks instantly."),
	wield_image = "wieldhand.png",
	wield_scale = {x=1.0,y=1.0,z=2.0},
	-- According to Minecraft Wiki, the exact range is 3.975.
	-- Minetest seems to only support whole numbers, so we use 4.
	range = hand_range,
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level = 0,
		groupcaps = groupcaps,
		damage_groups = {fleshy=1},
	},
	groups = hand_groups,
})

-- Help texts
local pickaxe_longdesc = S("Pickaxes are mining tools to mine hard blocks, such as stone. A pickaxe can also be used as weapon, but it is rather inefficient.")
local axe_longdesc = S("An axe is your tool of choice to cut down trees, wood-based blocks and other blocks. Axes deal a lot of damage as well, but they are rather slow.")
local sword_longdesc = S("Swords are great in melee combat, as they are fast, deal high damage and can endure countless battles. Swords can also be used to cut down a few particular blocks, such as cobwebs.")
local shovel_longdesc = S("Shovels are tools for digging coarse blocks, such as dirt, sand and gravel. They can also be used to turn grass blocks to grass paths. Shovels can be used as weapons, but they are very weak.")
local shovel_use = S("To turn a grass block into a grass path, hold the shovel in your hand, then use (rightclick) the top or side of a grass block. This only works when there's air above the grass block.")
local shears_longdesc = S("Shears are tools to shear sheep and to mine a few block types. Shears are a special mining tool and can be used to obtain the original item from grass, leaves and similar blocks that require cutting.")
local shears_use = S("To shear sheep or carve faceless pumpkins, use the “place” key on them. Faces can only be carved at the side of faceless pumpkins. Mining works as usual, but the drops are different for a few blocks.")

local wield_scale = { x = 1.8, y = 1.8, z = 1 }

-- Picks
minetest.register_tool("mcl_tools:pick_wood", {
	description = S("Wooden Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	_doc_items_hidden = false,
	inventory_image = "default_tool_woodpick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=2, enchantability=15 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=1,
		groupcaps={
			pickaxey_dig_wood = {times=mcl_autogroup.digtimes.pickaxey_dig_wood, uses=60, maxlevel=0},
		},
		damage_groups = {fleshy=2},
		punch_attack_uses = 30,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "group:wood",
})
minetest.register_tool("mcl_tools:pick_stone", {
	description = S("Stone Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	inventory_image = "default_tool_stonepick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=3, enchantability=5 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=3,
		groupcaps={
			pickaxey_dig_stone = {times=mcl_autogroup.digtimes.pickaxey_dig_stone, uses=132, maxlevel=0},
		},
		damage_groups = {fleshy=3},
		punch_attack_uses = 66,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:cobble",
})
minetest.register_tool("mcl_tools:pick_iron", {
	description = S("Iron Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	inventory_image = "default_tool_steelpick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=4, enchantability=14 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=4,
		groupcaps={
			pickaxey_dig_iron = {times=mcl_autogroup.digtimes.pickaxey_dig_iron , uses=251, maxlevel=0},
		},
		damage_groups = {fleshy=4},
		punch_attack_uses = 126,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:iron_ingot",
})
minetest.register_tool("mcl_tools:pick_gold", {
	description = S("Golden Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	inventory_image = "default_tool_goldpick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=6, enchantability=22 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=2,
		groupcaps={
			pickaxey_dig_gold = {times=mcl_autogroup.digtimes.pickaxey_dig_gold , uses=33, maxlevel=0},
		},
		damage_groups = {fleshy=2},
		punch_attack_uses = 17,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:gold_ingot",
})
minetest.register_tool("mcl_tools:pick_diamond", {
	description = S("Diamond Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	inventory_image = "default_tool_diamondpick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=5,
		groupcaps={
			pickaxey_dig_diamond = {times=mcl_autogroup.digtimes.pickaxey_dig_diamond, uses=1562, maxlevel=0},
		},
		damage_groups = {fleshy=5},
		punch_attack_uses = 781,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:diamond",
})

local get_shovel_dig_group = function(itemstring)
	local string_start = itemstring:sub(1, 21)
	if string_start == "mcl_tools:shovel_wood" then
		return "shovely_dig_wood"
	elseif string_start == "mcl_tools:shovel_ston" then
		return "shovely_dig_stone"
	elseif string_start == "mcl_tools:shovel_iron" then
		return "shovely_dig_iron"
	elseif string_start == "mcl_tools:shovel_gold" then
		return "shovely_dig_gold"
	elseif string_start == "mcl_tools:shovel_diam" then
		return "shovely_dig_diamond"
	else
		-- Fallback
		return "shovely_dig_wood"
	end
end

local make_grass_path = function(itemstack, placer, pointed_thing)
	-- Use pointed node's on_rightclick function first, if present
	local node = minetest.get_node(pointed_thing.under)
	if placer and not placer:get_player_control().sneak then
		if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
			return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack) or itemstack
		end
	end

	-- Only make grass path if tool used on side or top of target node
	if pointed_thing.above.y < pointed_thing.under.y then
		return itemstack
	end

	if (minetest.get_item_group(node.name, "grass_block") == 1) then
		local above = table.copy(pointed_thing.under)
		above.y = above.y + 1
		if minetest.get_node(above).name == "air" then
			if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
				minetest.record_protection_violation(pointed_thing.under, placer:get_player_name())
				return itemstack
			end

			if not minetest.is_creative_enabled(placer:get_player_name()) then
				-- Add wear, as if digging a level 0 shovely node
				local toolname = itemstack:get_name()
				local def = minetest.registered_items[toolname]
				local group = get_shovel_dig_group(toolname)
				local toolcaps = itemstack:get_tool_capabilities()
				local base_uses = toolcaps.groupcaps[group].uses
				local maxlevel = toolcaps.groupcaps[group].maxlevel
				local uses = base_uses * math.pow(3, maxlevel)
				local wear = math.ceil(65535 / uses)
				itemstack:add_wear(wear)
			end
			minetest.sound_play({name="default_grass_footstep", gain=1}, {pos = above}, true)
			minetest.swap_node(pointed_thing.under, {name="mcl_core:grass_path"})
		end
	end
	return itemstack
end

local carve_pumpkin
if minetest.get_modpath("mcl_farming") then
	carve_pumpkin = function(itemstack, placer, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
		local node = minetest.get_node(pointed_thing.under)
		if placer and not placer:get_player_control().sneak then
			if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
				return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack) or itemstack
			end
		end

		-- Only carve pumpkin if used on side
		if pointed_thing.above.y ~= pointed_thing.under.y then
			return
		end
		if node.name == "mcl_farming:pumpkin" then
			if not minetest.is_creative_enabled(placer:get_player_name()) then
				-- Add wear (as if digging a shearsy node)
				local toolname = itemstack:get_name()
				local def = minetest.registered_items[toolname]
				local group = get_shovel_dig_group(toolname)
				local base_uses = def.tool_capabilities.groupcaps["shearsy_dig"].uses
				local maxlevel = def.tool_capabilities.groupcaps["shearsy_dig"].maxlevel
				local uses = base_uses * math.pow(3, maxlevel)
				local wear = math.ceil(65535 / uses)
				itemstack:add_wear(wear)
			end
			minetest.sound_play({name="default_grass_footstep", gain=1}, {pos = above}, true)
			local dir = vector.subtract(pointed_thing.under, pointed_thing.above)
			local param2 = minetest.dir_to_facedir(dir)
			minetest.swap_node(pointed_thing.under, {name="mcl_farming:pumpkin_face", param2 = param2})
			minetest.add_item(pointed_thing.above, "mcl_farming:pumpkin_seeds 4")
		end
		return itemstack
	end
end

-- Shovels
minetest.register_tool("mcl_tools:shovel_wood", {
	description = S("Wooden Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	_doc_items_hidden = false,
	inventory_image = "default_tool_woodshovel.png",
	wield_image = "default_tool_woodshovel.png^[transformR90",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=2, enchantability=15 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			shovely_dig_wood = {times=mcl_autogroup.digtimes.shovely_dig_wood, uses=60, maxlevel=0},
		},
		damage_groups = {fleshy=2},
		punch_attack_uses = 30,
	},
	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "group:wood",
})
minetest.register_tool("mcl_tools:shovel_stone", {
	description = S("Stone Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	inventory_image = "default_tool_stoneshovel.png",
	wield_image = "default_tool_stoneshovel.png^[transformR90",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=3, enchantability=5 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=3,
		groupcaps={
			shovely_dig_stone = {times=mcl_autogroup.digtimes.shovely_dig_stone, uses=132, maxlevel=0},
		},
		damage_groups = {fleshy=3},
		punch_attack_uses = 66,
	},
	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:cobble",
})
minetest.register_tool("mcl_tools:shovel_iron", {
	description = S("Iron Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	inventory_image = "default_tool_steelshovel.png",
	wield_image = "default_tool_steelshovel.png^[transformR90",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=4, enchantability=14 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=4,
		groupcaps={
			shovely_dig_iron = {times=mcl_autogroup.digtimes.shovely_dig_iron, uses=251, maxlevel=0},
		},
		damage_groups = {fleshy=4},
		punch_attack_uses = 126,
	},
	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:iron_ingot",
})
minetest.register_tool("mcl_tools:shovel_gold", {
	description = S("Golden Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	inventory_image = "default_tool_goldshovel.png",
	wield_image = "default_tool_goldshovel.png^[transformR90",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=6, enchantability=22 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=2,
		groupcaps={
			shovely_dig_gold = {times=mcl_autogroup.digtimes.shovely_dig_gold, uses=33, maxlevel=0},
		},
		damage_groups = {fleshy=2},
		punch_attack_uses = 17,
	},
	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:gold_ingot",
})
minetest.register_tool("mcl_tools:shovel_diamond", {
	description = S("Diamond Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	inventory_image = "default_tool_diamondshovel.png",
	wield_image = "default_tool_diamondshovel.png^[transformR90",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=5,
		groupcaps={
			shovely_dig_diamond = {times=mcl_autogroup.digtimes.shovely_dig_diamond, uses=1562, maxlevel=0},
		},
		damage_groups = {fleshy=5},
		punch_attack_uses = 781,
	},
	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:diamond",
})

-- Axes
minetest.register_tool("mcl_tools:axe_wood", {
	description = S("Wooden Axe"),
	_doc_items_longdesc = axe_longdesc,
	_doc_items_hidden = false,
	inventory_image = "default_tool_woodaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=2, enchantability=15 },
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			axey_dig_wood = {times=mcl_autogroup.digtimes.axey_dig_wood, uses=60, maxlevel=0},
		},
		damage_groups = {fleshy=7},
		punch_attack_uses = 30,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "group:wood",
})
minetest.register_tool("mcl_tools:axe_stone", {
	description = S("Stone Axe"),
	_doc_items_longdesc = axe_longdesc,
	inventory_image = "default_tool_stoneaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=3, enchantability=5 },
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=3,
		groupcaps={
			axey_dig_stone = {times=mcl_autogroup.digtimes.axey_dig_stone, uses=132, maxlevel=0},
		},
		damage_groups = {fleshy=9},
		punch_attack_uses = 66,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:cobble",
})
minetest.register_tool("mcl_tools:axe_iron", {
	description = S("Iron Axe"),
	_doc_items_longdesc = axe_longdesc,
	inventory_image = "default_tool_steelaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=4, enchantability=14 },
	tool_capabilities = {
		-- 1/0.9
		full_punch_interval = 1.11111111,
		max_drop_level=4,
		groupcaps={
			axey_dig_iron = {times=mcl_autogroup.digtimes.axey_dig_iron, uses=251, maxlevel=0},
		},
		damage_groups = {fleshy=9},
		punch_attack_uses = 126,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:iron_ingot",
})
minetest.register_tool("mcl_tools:axe_gold", {
	description = S("Golden Axe"),
	_doc_items_longdesc = axe_longdesc,
	inventory_image = "default_tool_goldaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=6, enchantability=22 },
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			axey_dig_gold= {times=mcl_autogroup.digtimes.axey_dig_gold, uses=33, maxlevel=0},
		},
		damage_groups = {fleshy=7},
		punch_attack_uses = 17,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:gold_ingot",
})
minetest.register_tool("mcl_tools:axe_diamond", {
	description = S("Diamond Axe"),
	_doc_items_longdesc = axe_longdesc,
	inventory_image = "default_tool_diamondaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=5,
		groupcaps={
			axey_dig_diamond = {times=mcl_autogroup.digtimes.axey_dig_diamond, uses=1562, maxlevel=0},
		},
		damage_groups = {fleshy=9},
		punch_attack_uses = 781,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:diamond",
})

-- Swords
minetest.register_tool("mcl_tools:sword_wood", {
	description = S("Wooden Sword"),
	_doc_items_longdesc = sword_longdesc,
	_doc_items_hidden = false,
	inventory_image = "default_tool_woodsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=2, enchantability=15 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=1,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig , uses=60, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig , uses=60, maxlevel=0},
		},
		damage_groups = {fleshy=4},
		punch_attack_uses = 60,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "group:wood",
})
minetest.register_tool("mcl_tools:sword_stone", {
	description = S("Stone Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "default_tool_stonesword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=3, enchantability=5 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=3,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig , uses=132, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig , uses=132, maxlevel=0},
		},
		damage_groups = {fleshy=5},
		punch_attack_uses = 132,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:cobble",
})
minetest.register_tool("mcl_tools:sword_iron", {
	description = S("Iron Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "default_tool_steelsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=4, enchantability=14 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=4,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig, uses=251, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig , uses=251, maxlevel=0},
		},
		damage_groups = {fleshy=6},
		punch_attack_uses = 251,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:iron_ingot",
})
minetest.register_tool("mcl_tools:sword_gold", {
	description = S("Golden Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "default_tool_goldsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=6, enchantability=22 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=2,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig, uses=33, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig, uses=33, maxlevel=0},
		},
		damage_groups = {fleshy=4},
		punch_attack_uses = 33,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:gold_ingot",
})
minetest.register_tool("mcl_tools:sword_diamond", {
	description = S("Diamond Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "default_tool_diamondsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=5,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig, uses=1562, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig, uses=1562, maxlevel=0},
		},
		damage_groups = {fleshy=7},
		punch_attack_uses = 1562,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:diamond",
})

--Shears
minetest.register_tool("mcl_tools:shears", {
	description = S("Shears"),
	_doc_items_longdesc = shears_longdesc,
	_doc_items_usagehelp = shears_use,
	inventory_image = "default_tool_shears.png",
	wield_image = "default_tool_shears.png",
	stack_max = 1,
	groups = { tool=1, shears=1, dig_speed_class=4, },
	tool_capabilities = {
	        full_punch_interval = 0.5,
	        max_drop_level=1,
	        groupcaps={
			shearsy_dig = {times=mcl_autogroup.digtimes.shearsy_dig, uses=238, maxlevel=0},
			shearsy_wool_dig = {times=mcl_autogroup.digtimes.shearsy_wool_dig, uses=238, maxlevel=0},
		}
	},
	on_place = carve_pumpkin,
	sound = { breaks = "default_tool_breaks" },
})


dofile(minetest.get_modpath("mcl_tools").."/crafting.lua")
dofile(minetest.get_modpath("mcl_tools").."/aliases.lua")
--dofile(minetest.get_modpath("mcl_tools").."/enchanting.lua")
