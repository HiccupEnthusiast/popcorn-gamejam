class_name CustomerInfo extends Resource

@export var name: String
@export var traits: PackedStringArray
@export var preferences: Dictionary[String, int]

static func random() -> CustomerInfo:
	return Globals.get_random_customer()


func repr() -> String:
	return "%s: %s, %s" % [name, traits, preferences]
