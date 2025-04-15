class_name CustomerDoor extends Node2D

const CUSTOMER_SCENE = preload("res://entities/customer/customer.tscn")

@export var spawner_timer: Timer
@export var spawn_point: Node2D

var valid_spots: Array[Vector2]
var grid: AStarGrid2D

func _ready():
	spawner_timer.timeout.connect(_spawn_customer)

func _spawn_customer():
	var customer = CUSTOMER_SCENE.instantiate()
	customer.objective = valid_spots[randi() % valid_spots.size()]
	customer.exit_point = spawn_point.global_position
	customer.request_path.connect(func(): _give_path(customer))
	owner.add_child(customer)
	customer.body.global_position = spawn_point.global_position
	customer.request_path.emit()

func _give_path(customer: Customer):
	var path = grid.get_point_path(customer.body.global_position / 16, customer.objective / 16)
	for i in range(path.size()):
		path[i] = path[i] + Vector2(8, 8)
	customer.path = path 
	pass
