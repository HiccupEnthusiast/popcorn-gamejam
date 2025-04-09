class_name Product extends Resource

@export var name: String

func _init(_name: String):
	name = _name

func repr() -> String:
	return name
