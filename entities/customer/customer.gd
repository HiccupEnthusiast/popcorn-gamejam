class_name Customer extends Entity

var objective: Vector2
var exit_point: Vector2
var exited_spawn: bool = false

func _physics_process(_delta: float) -> void:
	if body.global_position.distance_to(objective) < 20.0:
		objective = exit_point
	if body.global_position.distance_to(exit_point) < 20.0:
		if exited_spawn:
			queue_free()
	if body.global_position.distance_to(exit_point) > 20.0 and !exited_spawn:
		exited_spawn = true
	body.velocity = body.global_position.direction_to(objective) * 50.0 
	body.move_and_slide()
