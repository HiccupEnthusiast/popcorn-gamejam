class_name CustomerStateMachine extends Resource

enum State {
	Seeking,
	Walking,
	Idle,
	Exit,
	}

var customer: Customer
var current_state: State

enum Stages {
	Checkin = 1 << 0,
	Waiting = 1 << 1,
	}
var stages_done: int
var curr_stage: Stages = Stages.Checkin

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
		State.Idle: pass
		State.Seeking: _while_seeking(delta)
		State.Walking: _while_walking(delta)
		State.Exit: _while_exit(delta)

func _try_transition(delta: float) -> State:
	match current_state:
		State.Idle:
			if stages_done & Stages.Checkin and curr_stage == Stages.Checkin: 
				curr_stage = Stages.Waiting
				return State.Seeking
			elif stages_done & Stages.Waiting: 
				return State.Seeking
		State.Seeking: 
			if customer.path.size() > 0: return State.Walking
		State.Walking:
			if customer.path.size() == 0: 
				customer.objectives.remove_at(0)
				var dist = customer.body.global_position.distance_to(customer.exit_point)
				var dist_check = dist < customer.speed * delta
				if customer.objectives.size() == 0 and dist_check: return State.Exit
				return State.Idle
	return current_state
func _on_state_changed(old_state: State) -> void:
	if current_state == State.Idle: 
		spawn_stage_scn(curr_stage)
	Log.d("%s: %s -> %s" % [customer.name, State.keys()[old_state], State.keys()[current_state]])

func spawn_stage_scn(stage: Stages) -> void:
	var key: int = 1 >> (stage - 1)
	var name: String = Stages.keys()[key].to_lower()
	var scn: CustomerStage = load("res://world/cafe/customer/stages/%s.tscn" % name).instantiate()
	customer.body.add_child(scn)
	scn.interacted.connect(
		func(): 
			stages_done |= stage
			scn.queue_free()
			)

func _while_seeking(_delta: float) -> void:
	customer.request_path.emit()

func _while_walking(delta: float) -> void:
	var objective = customer.path[0]
	customer.move()
	if customer.body.global_position.distance_to(objective) < customer.speed * delta:
		customer.path.remove_at(0)

func _while_exit(_delta: float) -> void:
	customer.remove()
