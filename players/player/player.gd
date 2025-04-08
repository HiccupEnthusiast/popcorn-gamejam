class_name Player extends Entity

func _physics_process(_delta: float) -> void:
	body.move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	var vel = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		vel += Vector2.UP
	if Input.is_action_pressed("move_down"):
		vel += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		vel += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		vel += Vector2.RIGHT
	if vel.length() > 0:
		vel = vel.normalized() * 500.0
	body.velocity = vel

