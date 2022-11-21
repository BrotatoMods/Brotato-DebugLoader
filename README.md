# Brotato-DebugLoader

A fast alternative to setting the options in *debug_service.tscn*. Lets you quickly test different weapons, items and builds.

Works with dami's multi mod support (autoload that first, before this).


## Details

| Key          | Val |
| ------------ | --- |
| Version      | 1.0.2                      |
| Last updated | 2022-11-21 (21st Nov 2022) |
| Author       | Darkly77                   |
| Wiki         | https://brotato.wiki.spellsandguns.com/Mod:DebugLoader |
| Repo         | https://github.com/ithinkandicode/Brotato-DebugLoader  |

## Usage

### Add the framework to an existing mod

* Add to your project in a folder named `debug`
* Add it to your autoloads:
  * *Project > Project Settings > Autoload*
  * Click the folder icon at the top to locate this file
  * Leave the name as `DebugLoader`

### Using debug.json

* Put *debug.json* in a folder named "debug" in the game folder
* Edit *debug.json* and start the game

As the *debug.json* file has its own folder, you can keep as many *debug.json* variants as you need, swapping between them for different test setups.


## Options

| Option                  | Type  | Default | Notes                                 |
| ----------------------- | ----- | ------- | ------------------------------------- |
| debug_weapons           | array | `[]`    | Set your starting weapons (see below) |
| debug_items             | array | `[]`    | Set your starting items (see below)   |
| starting_wave           | int   | `1`     | Vanilla supports `1` - `21`           |
| starting_gold           | int   | `30`    | Sets initial gold                     |
| invulnerable            | bool  | `false` | Disables your hurtbox                 |
| instant_waves           | bool  | `false` | Waves only last 1 second. Good for checking rarer shop items |
| add_all_items           | bool  | `false` | Adds every item                       |
| add_all_weapons         | bool  | `false` | Adds every weapon (can go over limit) |
| unlock_all_chars        | bool  | `false` | Makes every character available       |
| unlock_all_difficulties | bool  | `false` | Makes every danger level available    |
| no_weapons              | bool  | `false` | Removes all weapons at the start of every wave |

### Weapons & Items

Add an array of weapon/item IDs to start with them. You **can** go over the weapon limit.

Weapons:

	"debug_weapons": [
		"weapon_spear_1",
		"weapon_spear_2",
		"weapon_spear_3",
		"weapon_spear_4",
	],

Items:

	"debug_items": [
		"item_acid",
		"item_bat"
	],

You can find the IDs in the project in Godot, in each tier's data.tres file. It's called **My ID** in the Inspector.

For example, for **Spear Tier 2**, view *res://weapons/melee/spear/2/spear_2_data.tres* and look at **My ID**.


## Notes

### Validation

Warning: Currently has no validation or checks to ensure JSON keys are all present and valid. If debug.json exists, the code expects it to be correct. Use [jsonlint.com](https://jsonlint.com) if you need to find issues in your JSON.

### Default debug.json

By default, debug.json looks like this, using values from vanilla:

	{
		"debug_weapons": [],
		"debug_items": [],
		"starting_wave": 1,
		"starting_gold": 30,
		"invulnerable": false,
		"instant_waves": false,
		"add_all_items": false,
		"add_all_weapons": false,
		"unlock_all_chars": false,
		"unlock_all_difficulties": false,
		"no_weapons": false
	}

### Credits

Massive thank you to dami, who figured out how to fix a critical bug in Godot that prevented most of this script from working correctly.
