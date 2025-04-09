class_name TransitionTile extends Interactable

@export var spawn_point: Node2D
@export var target_scene_path: String 
@export var target_door: String

func _interact() -> void:
	SceneSwticher.goto_scene("res://world/%s/%s.tscn" % [target_scene_path, target_scene_path], target_door)
