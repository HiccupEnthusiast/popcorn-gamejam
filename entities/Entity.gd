class_name Entity extends Node2D

@onready var body: CharacterBody2D = $Body
@export var stats: EntityStats

func _take_damage(_damage: AttackStats) -> void:
	pass
