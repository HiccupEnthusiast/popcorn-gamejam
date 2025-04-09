extends CanvasLayer

@export var close_button: Button

func _ready() -> void:
	close_button.pressed.connect(queue_free)
