@tool
extends Node

var scripts = [
	preload("res://tiles post import/ground-collisions-import.gd"),
	preload("res://tiles post import/platform-collisions-import.gd")
]

func post_import(tileset: TileSet) -> TileSet:
	for script in scripts:
		var instance = script.new()
		tileset = instance.post_import(tileset)

	return tileset
