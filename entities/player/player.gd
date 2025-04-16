class_name Player extends Aggresor 

const BULLET = preload("res://entities/player/bullet.tscn")

@onready var interaction_area: Area2D = $Body/InteractionArea
var interaction_spots: Array[Interactable] = []

func _ready() -> void:
	super._ready()
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

	if Input.is_action_just_pressed("shoot"):
		attack_routine()

	if Input.is_action_just_pressed("confirm") and interaction_spots.size() > 0:
		interaction_spots[-1]._interact()

func _attack() -> void:
	var bullet = BULLET.instantiate()
	bullet.global_position = body.global_position
	bullet.stats = attack
	add_child(bullet)
	bullet.direction = body.global_position.direction_to(get_global_mouse_position())

func _take_damage(_damage: AttackStats) -> void:
	#Log.d("player took damage")
	pass
