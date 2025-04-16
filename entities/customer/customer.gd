class_name Customer extends Entity

var state_machine: CustomerStateMachine = CustomerStateMachine.new()
@export var customer_info: CustomerInfo

var last_point: Vector2
var objective: Vector2
var exit_point: Vector2: 
	get: return exit_point
	set(value): 
		# TODO: does this work when if the astargrid supports
		# a tile map with tiles on negative coordinates?
		# This may break if a tile map layer has a position offset 
		# that isn't a multiple of 16
		value.x = round(value.x / 16) * 16 + 8
		value.y = round(value.y / 16) * 16 + 8
		exit_point = value

var exited_spawn: bool = false
var path: PackedVector2Array 
var speed: float = 50.0

signal request_path()

func _ready() -> void:
	# Remove warn of not being used, it is being used by the state machine
	# Maybe moving the signal to the state machine is better
	var _ignore = request_path
	if customer_info == null:
		customer_info = CustomerInfo.random()
		if customer_info == null:
			Log.e("Couldn't generate new customer info, cancelling customer creation")
			queue_free()
	state_machine.customer = self

func _physics_process(delta: float) -> void:
	state_machine.state_routine(delta)

func move() -> void:
	body.velocity = body.global_position.direction_to(objective) * speed
	body.move_and_slide()
