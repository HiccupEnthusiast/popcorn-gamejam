extends Node2D

func _ready() -> void:
	for key in Globals.inventory.values():
		print(key.item.name, key.quantity)
