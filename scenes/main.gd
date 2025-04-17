extends Node2D

const INVENTORY = preload("res://world/cafe/inventory.tres")
const COMMON_BEAN = preload("res://world/cafe/ingredients/common_bean.tres")
const DARK_CHOCOLATE = preload("res://world/cafe/ingredients/dark_chocolate.tres")

func _ready() -> void:
	Globals.player = $Player
	Globals.camera = $PlayerCamera
	Globals.inventory = INVENTORY
	Log.current_level = Log.Level.DEBUG

	Globals.inventory.add_item(COMMON_BEAN)
	Globals.inventory.add_item(DARK_CHOCOLATE)

	SceneSwticher.goto_scene("res://world/cafe/cafe.tscn")
