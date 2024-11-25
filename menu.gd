extends Control

@onready var color:ColorRect=$ColorRect;

func _on_btn_reinicio_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	self.visible = false


func _on_btn_go_to_niveles_pressed():
	get_tree().paused = false
	var next_scene = load("res://mapa_niveles.tscn")
	get_tree().change_scene_to_file("res://mapa_niveles.tscn")
