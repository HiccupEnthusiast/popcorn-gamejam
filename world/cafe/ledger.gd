extends CanvasLayer

@export var close_button: Button 
@export var recipes_label: Label 

func _ready() -> void:
	close_button.pressed.connect(queue_free)
	for r in Globals.inventory.recipes_values():
		recipes_label.text += "%s\n" % r.repr()
