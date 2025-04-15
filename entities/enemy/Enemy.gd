class_name Enemy extends Aggresor

const ATTACK = preload("res://entities/enemy/melee_attack.tscn")

@export var state_machine: StateMachine

@onready var detection_area: Area2D = $Body/DetectionArea
var target: Player 
var target_pos: Vector2
var attack_progress: float
var attack_range: float = 30.0

func _draw() -> void:
	draw_circle(body.global_position - global_position, attack_range, Color.RED, false)

func _ready() -> void:
	super._ready()
	in_attack_zone = true
	state_machine.actor = self
	detection_area.area_entered.connect(_on_detection_entered)
	detection_area.area_exited.connect(_on_detection_exited)

func _on_detection_entered(area: Area2D) -> void:
	var parent = area.owner
	if parent is Player:
		target = parent
		target_pos = target.body.global_position

func _on_detection_exited(area: Area2D) -> void:
	var parent = area.owner
	if parent is Player:
		target = null 

func _physics_process(_delta: float) -> void:
	state_machine.state_routine(_delta)

func move():
	queue_redraw()
	body.velocity = body.global_position.direction_to(target_pos) * 100
	body.move_and_slide()

func _attack():
	var a = ATTACK.instantiate()
	a.attack_stats = attack
	add_child(a)
	var dir = body.global_position.direction_to(target.body.global_position)
	a.body.global_position = body.global_position + dir * 16

func _take_damage(_damage: AttackStats) -> void:
	stats.health -= _damage.damage
	if stats.health <= 0:
		queue_free()
