extends Node

var current_scene: Node = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)

func goto_scene(path: String, spawn_point = null) -> void:
	current_scene = get_tree().current_scene
	__deferred_goto_scene.call_deferred(path, spawn_point)

func __deferred_goto_scene(path: String, spawn_target) -> void:
	if spawn_target != null:
		Log.d("Changing scene to from '%s' to '%s' at '%s'" % [current_scene.name, path, spawn_target])
	else: 
		Log.d("Changing scene to from '%s' to '%s'" % [current_scene.name, path])
	current_scene.remove_child(Globals.player)
	current_scene.remove_child(Globals.camera)
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	current_scene.add_child(Globals.player)
	current_scene.add_child(Globals.camera)
	if spawn_target != null:
		var node_path = "TransitionTiles/%s" % spawn_target
		var spawn_point_node = current_scene.get_node(node_path)
		var a := spawn_point_node as TransitionTile
		if a != null:
			Globals.player.body.global_position = a.spawn_point.global_position
		else:
			Log.e("Spawn target '%s' selected but it isn't a TransitionTile" % spawn_target)
	else: 
		Log.i("Chaging scene with no spawn point")
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	scene_changed.emit(spawn_target)

signal scene_changed(spawn_point)
