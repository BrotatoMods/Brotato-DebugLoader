extends Node

# DebugLoader v1.0.2
#
# Version: 1.0.2
# Author:  Darkly77 (with help from dami)
# Wiki:    https://brotato.wiki.spellsandguns.com/Mod:DebugLoader
# Repo:    https://github.com/ithinkandicode/Brotato-DebugLoader

const debug_path = "res://debug/"
const json_path  = "res://debug/debug.json"

func _ready():
	print( "[debug_loader] Ready" )

	var json_file = File.new()
	var json_exists = json_file.file_exists( json_path )

	if !json_exists:
		print("[debug_loader] debug.json could not be found")

	else:
		print("[debug_loader] debug.json exists...")

		# Read json
		json_file.open( json_path, File.READ )
		var content = json_file.get_as_text()
		var dictionary = parse_json( content )
		json_file.close()

		# Debug: Print the full json contents
		# print("[debug_loader] JSON:" + dictionary)

		# Weapons/Items: Log number of each
		print( "[debug_loader] Weapons count: " + str( dictionary.debug_weapons.size() ) )
		print( "[debug_loader] Items   count: " + str( dictionary.debug_items.size() ) )

		var add_weapons = []
		var add_items = []

		# Weapons
		for i in dictionary.debug_weapons.size():
			var weapon_id = dictionary.debug_weapons[i]
			var weapon_load = ItemService.get_element( ItemService.weapons, weapon_id )
			add_weapons.push_back( weapon_load )
			print( "[debug_loader] Added weapon: " + weapon_id )

		# Items
		for i in dictionary.debug_items.size():
			var item_id = dictionary.debug_items[i]
			var item_load = ItemService.get_element( ItemService.items, item_id )
			add_items.push_back( item_load )
			print( "[debug_loader] Added item: " + item_id )

		# Notes on this hack: This fixes a weird issue where Godot is
		# assigning the same data to BOTH arrays, because (for some reason) it
		# considers both empty arrays as only one. This makes the game crash when
		# you start a run, because the game tries to load weapons as items (and.
		# vice versa). This workaround fixes it, and was worked out by dami (ty!)
		# Context: https://discord.com/channels/630060181086142487/1044269709677309973/1044318615417143448
		DebugService.debug_weapons = DebugService.debug_weapons.duplicate()
		DebugService.debug_items   = DebugService.debug_items.duplicate()

		## Add weapons & items
		DebugService.debug_weapons.append_array(add_weapons)
		DebugService.debug_items.append_array(add_items)

		# Misc
		# Excludes challenge unlocks because they can affect save files
		DebugService.starting_wave    = dictionary.starting_wave    # default: 1 - 21 (int)
		DebugService.starting_gold    = dictionary.starting_gold    # default: 30 (int)
		DebugService.invulnerable     = dictionary.invulnerable     # default: false - No hurtbox
		DebugService.instant_waves    = dictionary.instant_waves    # default: false - Waves last 1 second
		DebugService.add_all_items    = dictionary.add_all_items    # default: false - Adds every item
		DebugService.add_all_weapons  = dictionary.add_all_weapons  # default: false - Adds every weapon (can go over limit)
		DebugService.unlock_all_chars = dictionary.unlock_all_chars # default: false - Makes every character available
		DebugService.unlock_all_difficulties = dictionary.unlock_all_difficulties # default: false - Makes every danger level available
		DebugService.no_weapons       = dictionary.no_weapons       # default: false - Removes all weapons

		print( "[debug_loader] Finished" )
