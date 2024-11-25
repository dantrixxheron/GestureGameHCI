extends ColorRect

func _ready():
	ThemeManager.theme_changed.connect(_on_theme_changed)
	_apply_theme()

func _on_theme_changed():
	_apply_theme()

func _apply_theme():
	if ThemeManager.is_dark_theme:
		color = Color.WHITE
	else:
		color = Color.BLACK
