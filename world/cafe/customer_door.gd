class_name CustomerDoor extends Node2D

const CUSTOMER_SCENE = preload("res://entities/customer/customer.tscn")

@export var spawner_timer: Timer
@export var spawn_point: Node2D

var valid_spots: Array[Vector2]

func _ready():
	spawner_timer.timeout.connect(_spawn_customer)

func _spawn_customer():
	var customer = CUSTOMER_SCENE.instantiate()
	customer.position = spawn_point.global_position
	customer.objective = valid_spots[randi() % valid_spots.size()]
	customer.exit_point = spawn_point.global_position
	owner.add_child(customer)
