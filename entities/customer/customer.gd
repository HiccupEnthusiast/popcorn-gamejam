class_name Customer extends Entity

var state_machine: CustomerStateMachine = CustomerStateMachine.new()
@export var customer_info: CustomerInfo
var wants: Dictionary[String, int] 

var last_point: Vector2
var objectives: PackedVector2Array 
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
var speed: float = 250.0

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

	var num_wants = 1
	num_wants += 0 if randf() < 0.65 else 1
	num_wants += 0 if randf() < 0.1 else 1

	Log.i("Attempting to spawn customer %s with %d wants" % [customer_info.name, num_wants])

	var rng = RandomNumberGenerator.new()
	for i in range(num_wants):
		var factor = randi_range(1, 20)
		var found_valid = false
		var prop
		var tries = 0
		while not found_valid:
			var use_preferences = randf() < 0.8
			if use_preferences:
				var props = customer_info.preferences.keys()
				var raw_weights = customer_info.preferences.values()
				var weights = PackedFloat32Array(raw_weights)
				var idx = rng.rand_weighted(weights)
				prop = props[idx]
			else:
				var idx = rng.randi_range(0, Globals.PROPERTIES.size() - 1)
				prop = Globals.PROPERTIES[idx]

			if not prop in wants or tries > 10:
				found_valid = true
			tries += 1

		wants[prop] = factor * 25
	Log.i("Actual wants: %s" % wants)
	state_machine.customer = self

func _physics_process(delta: float) -> void:
	var points = PackedVector2Array()
	points.append(body.global_position)
	points.append_array(path)
	$Path.points = points
	state_machine.state_routine(delta)

func move() -> void:
	body.velocity = body.global_position.direction_to(path[0]) * speed
	body.move_and_slide()

func remove() -> void:
	Globals.deactive_customer(customer_info)
	queue_free()
