class_name StateMachine extends Resource

enum State {
	Idle,
	Chase,
	Investigate,
	Attack,
	Dead,
	}
@export var current_state: State = State.Idle
var actor: Enemy 

func state_routine(delta: float) -> void:
	var trans = _try_transition(delta)
	if trans is State: 
		transition_routine(trans)
	_state_logic(delta)

func transition_routine(new_state: State) -> void:
	var old_state = current_state
	current_state = new_state
	_on_state_changed(old_state)


func _state_logic(delta: float) -> void:
	match current_state:
		State.Idle: _while_idle(delta)
		State.Chase: _while_chase(delta)
		State.Investigate: _while_investigate(delta)
		State.Attack: _while_attack(delta)
		State.Dead: _while_dead(delta)
func _try_transition(_delta: float):
	return null
func _on_state_changed(_old_state: State) -> void:
	pass


func _while_idle(_delta: float) -> void:
	pass
func _while_chase(_delta: float) -> void:
	pass
func _while_investigate(_delta: float) -> void:
	pass
func _while_attack(_delta: float) -> void:
	pass
func _while_dead(_delta: float) -> void:
	pass
