# Agregar este script a los botones que quieras que cambien
extends Button

func _ready():
	ThemeManager.theme_changed.connect(_on_theme_changed)
	_apply_theme()

func _on_theme_changed():
	_apply_theme()

func _apply_theme():
	if ThemeManager.is_dark_theme:
		add_theme_color_override("font_color", Color.BLACK)
		add_theme_stylebox_override("normal", _create_stylebox(Color.WHITE))
	else:
		add_theme_color_override("font_color", Color.WHITE)
		add_theme_stylebox_override("normal", _create_stylebox(Color.BLACK))

func _create_stylebox(color: Color) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_left = 4
	style.corner_radius_bottom_right = 4
	return style
