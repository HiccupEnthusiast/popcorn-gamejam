extends CanvasLayer

@onready var close_button: Button = $MarginContainer/PanelContainer/VBoxContainer/Button
@onready var recipes_layer: Label = $MarginContainer/PanelContainer/VBoxContainer/RecipesLabel

func _ready() -> void:
	close_button.pressed.connect(queue_free)
	for r in Globals.inventory.recipes_values():
		recipes_layer.text += "%s\n" % r.repr()
