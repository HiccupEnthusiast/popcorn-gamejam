extends CanvasLayer 

@onready var available_contatiner: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VSplitContainer/HSplitContainer/Right/VBoxContainer
@onready var selected_container: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VSplitContainer/HSplitContainer/Left/VBoxContainer

func _ready() -> void:
	for entry in Globals.inventory.values():
		var button := Button.new()
		button.text = entry.item.name
		button.focus_mode = Control.FOCUS_NONE
		button.pressed.connect(_on_available_clicked)
		available_contatiner.add_child(button)

func _on_available_clicked() -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("move_up") or \
	Input.is_action_pressed("move_down") or \
	Input.is_action_pressed("move_left") or \
	Input.is_action_pressed("move_right"):
		queue_free()
	if Input.is_action_pressed("confirm"):
		get_viewport().set_input_as_handled()
		queue_free()
