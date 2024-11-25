extends Node

@onready var http_request = $HTTPRequest
var url = "http://127.0.0.1:5000/gesture"
var last_gesture = ""
@onready var menuWin: Control = $Menu
@onready var menuSettings: Control = $menuFloat
@onready var frameFoto:TextureRect=$CanvasLayer/accionRealizando/ColorRect/TextureRect

func _ready():
	menuWin.visible = false
	menuSettings.visible = false
	config_img_movement_default("res://recursos/imgs_movimiento/ALTO.png")

func _process(delta):
		start_request()

func start_request():
	# Realiza la solicitud al servidor Flask
	http_request.request(url)

func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		# Crea una instancia de JSON y luego usa el método parse()
		var json_instance = JSON.new()
		var json_response = json_instance.parse(body.get_string_from_utf8())

		# Verifica si el resultado del parsing es un error
		if json_response == OK:
			# Accede al gesto
			var gesture_data = json_instance.get_data()["gesture"]
			print(gesture_data)  # Verifica los datos recibidos
			# Ejecuta alguna acción según los datos del gesto
			_process_gesture_data(gesture_data)
		else:
			print("Error al parsear el JSON: ", json_response)  # Imprime el código de error
	else:
		print("Error en la solicitud HTTP. Código: ", response_code)

func _process_gesture_data(gesture_data: String):
	# Actualiza la dirección del personaje según el gesto recibido
	match gesture_data:
		"left":
			$CanvasLayer/Player.move_character(Vector2(-1, 0))  # Mueve a la izquierda
			config_img_movement_default("res://recursos/imgs_movimiento/IZQUIERDA.png")
		"right":
			$CanvasLayer/Player.move_character(Vector2(1, 0))  # Mueve a la derecha
			config_img_movement_default("res://recursos/imgs_movimiento/DERECHA.png")
		"up":
			$CanvasLayer/Player.move_character(Vector2(0, -1))  # Sube
			config_img_movement_default("res://recursos/imgs_movimiento/ARRIBA.png")
		"down":
			$CanvasLayer/Player.move_character(Vector2(0, 1))  # Baja
			config_img_movement_default("res://recursos/imgs_movimiento/ABAJO.png")
		"stop":
			$CanvasLayer/Player.stop_movement()
			config_img_movement_default("res://recursos/imgs_movimiento/ALTO.png")

func config_img_movement_default(source:String):
	frameFoto.texture=load(source)
	frameFoto.expand_mode=TextureRect.EXPAND_FIT_HEIGHT
	frameFoto.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	frameFoto.size=Vector2(217, 296)
	frameFoto.position=Vector2(47, 3)

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		win()

func win():
	get_tree().paused = true
	menuWin.visible = true
	$CanvasLayer/accionRealizando.visible=false

func _on_btn_open_menu_float_pressed():
	get_tree().paused = true
	menuSettings.visible = true
