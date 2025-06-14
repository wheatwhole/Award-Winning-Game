@tool
extends Node

var scripts = [
	preload("./ground-collisions-import.gd"),
	preload("./one-way-collisions-import.gd"),
]

func post_import(tileset: TileSet) -> TileSet:
	for script in scripts:
		var instance = script.new()
		tileset = instance.post_import(tileset)

	return tileset
