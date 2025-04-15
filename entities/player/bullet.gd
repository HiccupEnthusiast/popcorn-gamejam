class_name Bullet extends Node2D 

var stats: AttackStats
var direction: Vector2
@onready var body: Area2D = $Body

func _ready() -> void:
	var ttl = get_tree().create_timer(2.0)
	ttl.timeout.connect(queue_free)

	body.area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	body.global_position += direction * 1000 * delta

func _on_area_entered(area: Area2D) -> void:
	var o = area.owner
	if o is Entity:
		o._take_damage(stats)
		queue_free()
