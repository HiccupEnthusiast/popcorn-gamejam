extends Node2D

const LEDGER_SCENE = preload("res://world/cafe/ledger.tscn")
const BUILD_UI_SCENE = preload("res://world/cafe/build_mode_ui.tscn")

@onready var layer: CanvasLayer = $CanvasLayer
@onready var button_containers = $CanvasLayer/MarginContainer/HBoxContainer
@onready var customer_door: CustomerDoor = $CustomerDoor
@export var build_button: Button 
@export var ledger_button: Button

var grid: AStarGrid2D

func _ready() -> void:
	grid = AStarGrid2D.new()
	grid.cell_size = Vector2(16, 16)
	# TODO: make this dynamic
	grid.size = Vector2(32, 32)
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	grid.jumping_enabled = true
	grid.update()
	for i in range(grid.size.x * grid.size.y):
		grid.set_point_solid(Vector2i(i % grid.size.x, i / grid.size.x), true)

	Globals.player.in_attack_zone = false
	var pos: Array[Vector2]

	var tile_map: TileMapLayer = $FloorTiles
	for cell in tile_map.get_used_cells_by_id(0):
		var p = tile_map.map_to_local(cell)
		# TODO: account for tiles placed at negative coordinates;
		# see also setter of exit_point of customer
		grid.set_point_solid(cell, false)
		pos.append(p)
	
	customer_door.valid_spots = pos
	customer_door.grid = grid
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
