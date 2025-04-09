extends Node

var current_level = Level.INFO

enum Level {
	DEBUG,
	INFO,
	WARN,
	ERROR,
}

var colors = {
	Level.DEBUG: "#40a02b",
	Level.INFO: "#04a5e5",
	Level.WARN: "#df8e1d",
	Level.ERROR: "#d20f39",
}

func message(msg: String, level: Level) -> void:
	if level < current_level: return
	var is_rich = true
	var level_tag = __level_tag(level, is_rich)
	var time = __time_tag(is_rich)
	print_rich("%s %s %s" % [time, level_tag, msg])

func d(msg: String) -> void:
	message(msg, Level.DEBUG)

func i(msg: String) -> void:
	message(msg, Level.INFO)

func w(msg: String) -> void:
	message(msg, Level.WARN)

func e(msg: String) -> void:
	message(msg, Level.ERROR)

func __level_tag(level: Level, is_rich: bool) -> String:
	var inner = Level.keys()[level]
	if is_rich:
		return "[color=%s]%s[/color]" % [colors[level], inner]
	else:
		return "%s" % [inner]

func __time_tag(is_rich: bool) -> String:
	var inner = Time.get_datetime_string_from_system(true)
	if is_rich:
		return "[color=dim_gray]%s[/color]" % [inner]
	else:
		return "%s" % [inner]

