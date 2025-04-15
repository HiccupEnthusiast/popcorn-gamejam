class_name CommonAi extends StateMachine

func _try_transition(_delta: float):
	match current_state:
		State.Idle: 
			if actor.target != null: return State.Chase
		State.Chase:
			if actor.target == null: return State.Investigate
			else:
				var dist = actor.target_pos.distance_to(actor.body.global_position)
				if dist < actor.attack_range: return State.Attack
		State.Investigate: 
			var dist = actor.target_pos.distance_to(actor.body.global_position)
			if actor.target != null: return State.Chase
			if dist < 4: return State.Idle
		State.Attack:
			if actor.in_cooldown:
				if actor.target == null: return State.Investigate
				var dist = actor.body.global_position.distance_to(actor.target.body.global_position)
				if dist > actor.attack_range: return State.Chase
	return null

func _on_state_changed(old_state: State) -> void:
	var c_name = State.keys()[old_state]
	var n_name = State.keys()[current_state]
	Log.d("%s: %s -> %s" % [actor.name, c_name, n_name])

func _while_chase(_delta: float) -> void:
	actor.target_pos = actor.target.body.global_position
	actor.move()

func _while_investigate(_delta: float) -> void:
	actor.move()

func _while_attack(_delta: float) -> void:
	actor.attack_routine()
