# Agregar este script a los labels que quieras que cambien
extends Label

func _ready():
	ThemeManager.theme_changed.connect(_on_theme_changed)
	_apply_theme()

func _on_theme_changed():
	_apply_theme()

func _apply_theme():
	if ThemeManager.is_dark_theme:
		add_theme_color_override("font_color", Color.WHITE)
	else:
		add_theme_color_override("font_color", Color.BLACK)
		print("texto en negro")
