extends Node

@onready var http_request = $HTTPRequest
var url = "http://127.0.0.1:5000/gesture"
var video_url = "http://127.0.0.1:5000/video_feed"
var last_gesture = ""
@onready var menuSettings:Control=$CanvasLayer/menuFloat
@onready var menuTuto:CanvasLayer=$verTuto
@onready var frameVideo:VideoStreamPlayer=$verTuto/VideoStreamPlayer
@onready var frameFoto:TextureRect=$accionRealizando/ColorRect/TextureRect
var videoUp=load("res://recursos/videos_tutorial/up_movement.ogv")
var videoDown=load("res://recursos/videos_tutorial/down_movement.ogv")
var videoLeft=load("res://recursos/videos_tutorial/left_movement.ogv")
var videoRight=load("res://recursos/videos_tutorial/right_movement.ogv")
var videoStop=load("res://recursos/videos_tutorial/stop_movement.ogv")

func _ready():
	# Realiza la primera solicitud GET al servidor Flask
	menuSettings.visible = false
	menuTuto.visible=false
	show_first_video()
	start_request()

func start_request():
	# Realiza la solicitud
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
		
	start_request()
# Actualiza la dirección del personaje
func _process_gesture_data(gesture_data: String):
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

func _on_btn_open_menu_float_pressed():
	get_tree().paused=true;
	menuSettings.visible=true;

func config_img_movement_default(source:String):
	frameFoto.texture=load(source)
	frameFoto.expand_mode=TextureRect.EXPAND_FIT_HEIGHT
	frameFoto.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	frameFoto.size=Vector2(217, 296)
	frameFoto.position=Vector2(47, 3)

func config_tuto_video_default(header:String,reto:String,video):
	get_tree().paused = true
	menuTuto.visible = true
	$verTuto/lblAction.text=header
	$verTuto/txtReto.text=reto
	frameVideo.stream=video
	frameVideo.play()
	frameVideo.loop=true
	frameVideo.scale=Vector2(.6,.6)
	frameVideo.position = Vector2(370, 220) # Ajusta la posición en pantalla
	
func show_first_video():
	# Configuración del texto del tutorial
	var titulo= "Movimiento arriba"
	var reto = "Alcanza el botón de menú con el personaje. ¡Inténtalo!"
	
	# Configuración del video
	config_tuto_video_default(titulo, reto, videoUp)


func _on_up_goal_body_entered(body):
	#texto
	var titulo="Movimiento abajo"
	var reto="Llega hasta el final de la pantalla. ¡Tú puedes!"
	#config video
	config_tuto_video_default(titulo, reto, videoDown)


func _on_down_goal_body_entered(body):
	var titulo="Movimiento a la izquierda"
	var reto="Llega hasta el borde izquierdo.\n¡Ya casi completas el tutorial!"
	#config video
	config_tuto_video_default(titulo, reto, videoLeft)

func _on_left_goal_body_entered(body):
	var titulo="Movimiento a la derecha"
	var reto="Llega hasta el borde derecho. ¡Estás por completarlo!"
	#config video
	config_tuto_video_default(titulo, reto, videoRight)


func _on_right_goal_body_entered(body):
	var titulo="Detén el dinosaurio"
	var reto = "Prueba diferentes movimientos y luego para el personaje.\n¡Ve al nivel cuando estés listo!"
	#config video
	config_tuto_video_default(titulo, reto, videoStop)
