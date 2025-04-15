class_name MeleeAttack extends Node2D 

var attack_stats: AttackStats
@onready var body: Area2D = $Body

func _ready() -> void:
	get_tree().create_timer(attack_stats.cooldown).timeout.connect(queue_free)
	body.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var parent = area.owner
	if parent is Player:
		parent._take_damage(attack_stats)
