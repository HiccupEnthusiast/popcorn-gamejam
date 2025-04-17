class_name CustomerStage extends Interactable

signal interacted()

var customer: Customer

func _interact() -> void:
	interacted.emit()
