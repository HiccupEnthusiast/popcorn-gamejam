class_name Aggresor extends Entity

var in_attack_zone: bool = false
@export var attack: AttackStats

var attack_timer: Timer
var in_cooldown: bool

func _ready() -> void:
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.wait_time = attack.cooldown
	attack_timer.one_shot = true
	attack_timer.timeout.connect(func():
		in_cooldown = false
	)

func _attack() -> void:
	pass

func attack_routine() -> void:
	if in_cooldown or not in_attack_zone: return
	in_cooldown = true
	_attack()
	attack_timer.start()
