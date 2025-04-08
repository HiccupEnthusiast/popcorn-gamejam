class_name TransitionTile extends Area2D

@export var spawn_point: Node2D
@export var target_scene_path: String 
@export var target_door: String
var is_occupied: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("confirm") and is_occupied:
		SceneSwticher.goto_scene("res://world/%s.tscn" % target_scene_path, target_door)

func _on_area_entered(body: Area2D) -> void:
	var parent = body.get_parent().get_parent()
	if parent is Player:
		is_occupied = true

func _on_area_exited(body: Area2D) -> void:
	var parent = body.get_parent().get_parent()
	if parent is Player:
		is_occupied = false
