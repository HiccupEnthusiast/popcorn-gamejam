class_name Interactable extends Area2D

const PLAYER_INTERACTABLE_LAYER = 1 << 2

func _ready() -> void:
	if collision_layer != 1:
		Log.w("'%s' Interactable collision mask was changed from default, this will be ignored" % name)
	collision_layer = PLAYER_INTERACTABLE_LAYER


func _interact() -> void:
	pass

