extends Control
func _ready():
	var menu_float = MenuFloat # Sin necesidad de `get_node`
	menu_float.connect("change_theme", Callable(self, "_on_change_theme"))
	# Conectar todos los nodos de los grupos relevantes
	for node in get_tree().get_nodes_in_group("bkgrnd"):
		menu_float.connect("change_theme", Callable(node, "_on_change_theme"))
	for node in get_tree().get_nodes_in_group("btn"):
		menu_float.connect("change_theme", Callable(node, "_on_change_theme"))
	for node in get_tree().get_nodes_in_group("lbl"):
		menu_float.connect("change_theme", Callable(node, "_on_change_theme"))

func _on_btn_go_to_tutorial_pressed():
	var next_escene=load("res://tutorial.tscn")
	get_tree().change_scene_to_file("res://tutorial.tscn")


func _on_btn_go_to_juego_pressed():
	var next_scene = load("res://laberinto.tscn")
	get_tree().change_scene_to_file("res://laberinto.tscn")
