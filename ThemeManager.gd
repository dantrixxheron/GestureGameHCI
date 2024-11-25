extends Node

signal theme_changed

var is_dark_theme: bool = false

func toggle_theme():
	is_dark_theme = !is_dark_theme
	emit_signal("theme_changed")
