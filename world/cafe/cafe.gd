extends Node2D

const LEDGER_SCENE = preload("res://world/cafe/ledger.tscn")

@onready var layer: CanvasLayer = $CanvasLayer
@onready var button_containers = $CanvasLayer/MarginContainer/HBoxContainer
@export var build_button: Button 
@export var ledger_button: Button

func _ready() -> void:
	ledger_button.pressed.connect(_show_ledger)


func _show_ledger() -> void:
	toggle_buttons()
	var ledger = LEDGER_SCENE.instantiate()
	add_child(ledger)
	ledger.close_button.pressed.connect(toggle_buttons)
	pass

func toggle_buttons() -> void:
	button_containers.visible = !button_containers.visible
