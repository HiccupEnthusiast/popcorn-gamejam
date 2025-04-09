extends Node2D

const LEDGER_SCENE = preload("res://world/cafe/ledger.tscn")
const BUILD_UI_SCENE = preload("res://world/cafe/build_mode_ui.tscn")

@onready var layer: CanvasLayer = $CanvasLayer
@onready var button_containers = $CanvasLayer/MarginContainer/HBoxContainer
@export var build_button: Button 
@export var ledger_button: Button

func _ready() -> void:
	build_button.pressed.connect(_show_build_ui)
	ledger_button.pressed.connect(_show_ledger)

func _show_build_ui() -> void:
	toggle_buttons()
	var build_ui = BUILD_UI_SCENE.instantiate()
	add_child(build_ui)
	build_ui.close_button.pressed.connect(toggle_buttons)

func _show_ledger() -> void:
	toggle_buttons()
	var ledger = LEDGER_SCENE.instantiate()
	add_child(ledger)
	ledger.close_button.pressed.connect(toggle_buttons)

func toggle_buttons() -> void:
	button_containers.visible = !button_containers.visible
