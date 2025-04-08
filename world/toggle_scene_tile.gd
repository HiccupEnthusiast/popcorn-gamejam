class_name ToggleSceneTile extends Interactable

@export var scene: PackedScene

func _interact() -> void:
	var s = scene.instantiate()
	owner.add_child(s)
