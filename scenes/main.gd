extends Node2D

func _ready() -> void:
	Globals.player = $Player
	Globals.camera = $PlayerCamera

	SceneSwticher.goto_scene("res://world/cafe.tscn")
