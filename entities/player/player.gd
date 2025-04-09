class_name Player extends Entity

@onready var interaction_area: Area2D = $Body/InteractionArea
var interaction_spots: Array[Interactable] = []

func _ready() -> void:
	interaction_area.area_entered.connect(_on_interactable_entered)
	interaction_area.area_exited.connect(_on_interactable_exited)

func _on_interactable_entered(interactable: Interactable) -> void:
	if interactable == null: return
	interaction_spots.append(interactable)
func _on_interactable_exited(interactable: Interactable) -> void:
	if interactable == null: return
	interaction_spots.erase(interactable)

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

	if Input.is_action_just_pressed("confirm") and interaction_spots.size() > 0:
		interaction_spots[-1]._interact()
