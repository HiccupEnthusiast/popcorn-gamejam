class_name PlayerCamera extends Camera2D

@export var player: Player 
var zoom_offset := 0.0:
	set(value):
		zoom_offset = clamp(value, -0.9, 4.0)

func _process(_delta: float):
	global_position = player.body.global_position

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		zoom_offset += 0.1
	if Input.is_action_just_pressed("zoom_out"):
		zoom_offset -= 0.1

	zoom = Vector2.ONE + Vector2.ONE * zoom_offset
