extends Node2D

func _ready() -> void:
	Globals.player = $Player
	Globals.camera = $PlayerCamera
	Log.d("debug")
	Log.i("info")
	Log.w("warning")
	Log.e("error")

	SceneSwticher.goto_scene("res://world/cafe.tscn")
