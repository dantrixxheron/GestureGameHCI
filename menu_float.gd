# menu_float.gd
extends Control

signal change_theme

@onready var btnContinuar: Button = $btnContinuar
@onready var btnReiniciar: Button = $btnReiniciar
@onready var btnGoToLevelsMap: Button = $btnGoToLevelsMap
@onready var btnCambiarTema: Button = $btnCambiarTema


func _on_btn_cambiar_tema_pressed():
	ThemeManager.toggle_theme()
	get_tree().paused = false
	self.visible = false

func _on_btn_continuar_pressed():
	get_tree().paused=false;
	self.visible=false;


func _on_btn_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	self.visible = false


func _on_btn_go_to_levels_map_pressed():
	get_tree().paused = false
	var next_scene = load("res://mapa_niveles.tscn")
	get_tree().change_scene_to_file("res://mapa_niveles.tscn")
