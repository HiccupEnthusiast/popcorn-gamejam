class_name CustomerDoor extends Node2D

const CUSTOMER_SCENE = preload("res://entities/customer/customer.tscn")

@export var spawner_timer: Timer
@export var spawn_point: Node2D
@export var capacity: int = 1

var valid_spots: Array[Vector2]
var grid: AStarGrid2D

func _ready():
	spawner_timer.timeout.connect(_spawn_customer)

func _spawn_customer():
	if !Globals.can_spawn_customer() or Globals.active_customers.size() >= capacity: return
	var customer = CUSTOMER_SCENE.instantiate()
	var objectives = PackedVector2Array()
	objectives.append(valid_spots[randi() % valid_spots.size()] / 16 * 16 + Vector2(8, 8))
	objectives.append(valid_spots[randi() % valid_spots.size()] / 16 * 16 + Vector2(8, 8))
	objectives.append(spawn_point.global_position / 16 * 16 + Vector2(8, 8))
	customer.objectives = objectives
	customer.exit_point = spawn_point.global_position
	customer.request_path.connect(func(): _give_path(customer))
	owner.add_child(customer)
	customer.body.global_position = spawn_point.global_position
	customer.request_path.emit()

func _give_path(customer: Customer):
	var path = grid.get_point_path(customer.body.global_position / 16, customer.objectives[0] / 16)
	if path.is_empty():
		if customer.objectives.size() > 1:
			Log.e("Customer %s has an unreachable exit, deleting" % customer.customer_info.name)
			customer.remove()
		else:
			Log.w("Customer %s has an unreachable objective, skipping it" % customer.customer_info.name)
			customer.objectives.remove_at(0)
	for i in range(path.size()):
		path[i] = path[i] + Vector2(8, 8)
	customer.path = path 
