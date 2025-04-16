class_name CustomerStateMachine extends Resource

enum State {
	Idle,
	Walking,
	Exit,
	}

var customer: Customer
var current_state: State

func state_routine(delta: float) -> void:
	var trans = _try_transition(delta)
	if trans != current_state:
		transition_routine(trans)
	_state_logic(delta)

func transition_routine(new_state: State) -> void:
	var old_state = current_state
	current_state = new_state
	_on_state_changed(old_state)

func _state_logic(delta: float) -> void:
	match current_state:
		State.Idle: _while_idle(delta)
		State.Walking: _while_walking(delta)
		State.Exit: _while_exit(delta)

func _try_transition(delta: float) -> State:
	match current_state:
		State.Idle: 
			if customer.path.size() > 0: return State.Walking
		State.Walking:
			if customer.path.size() == 0: 
				var dist = customer.body.global_position.distance_to(customer.exit_point)
				var dist_check = dist < customer.speed * delta
				if customer.objective == customer.exit_point and dist_check: return State.Exit
				return State.Idle
	return current_state
func _on_state_changed(_old_state: State) -> void:
	Log.d("%s: %s -> %s" % [customer.name, State.keys()[_old_state], State.keys()[current_state]])

func _while_idle(_delta: float) -> void:
	customer.objective = customer.exit_point
	customer.request_path.emit()

func _while_walking(delta: float) -> void:
	customer.objective = customer.path[0]
	if customer.body.global_position.distance_to(customer.objective) < customer.speed * delta:
		customer.path.remove_at(0)
	customer.move()

func _while_exit(_delta: float) -> void:
	Globals.deactive_customer(customer.customer_info)
	customer.queue_free()


