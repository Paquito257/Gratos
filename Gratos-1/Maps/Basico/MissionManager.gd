extends Node2D

var activo = false
var clicks = -1
var completados = 1
var contador = 1
var correcta = {"Nivel1": {"1": "6", "2": "Lineal", "3": "6"}, "Nivel2": {"1": "1990", "2": "9", "3": "1"}, "Nivel3": {"1":"8", "2":"mujer", "3":"14"}}
var revision = {"Nivel1": {"1": false,"2":false,"3":false}, "Nivel2": {"1": false, "2": false, "3": false}, "Nivel3": {"1": false, "2": false, "3": false}}
var preguntas = {"Nivel1": {"1": "Cuantas consonantes hay en la palabra 'palindromo'?", "2": "A que tipo función corresponde la siguiente expresión: y = mx+b?", "3": "Desde el inicio del siglo XXI cuantos años bisiestos ha habido?"}, "Nivel2": {"1":"En que año salió la PS1?", "2": "Cuantas generaciones hay actualmente de pokemon (2025)", "3": "A que es igual 0!"}, "Nivel3": {"1": "En mario 64, cuantas estrellas se pueden conseguir en cada nivel?", "2": "En la saga Metroid, la persona que se encuentra dentro de la armadura de Samus es un hombre o una mujer?", "3": "En el LoL (League of Legends) cuantos campeones pertenecientes a la raza 'yordle' hay?"}}
var pesca = false
var cajas = false
var respuesta = ""
var Trivia = false
var areaP = false
var dentro = false

var misiones = {
	"1": {"nombre": "Pesca", "descripcion": "Ayuda al aventurero a pescar para alimentar a los gatos", "completada": false},
	"2": {"nombre": "Busqueda", "descripcion": "El profesor X ha perdido sus libros, ayudalo a encontrarlos", "completada": false},
	"3": {"nombre": "Trivia", "descripcion": "Un misterioso aventurero te ofrece una buena recompensa a cambio de resolver una trivia, aunque te da mala espina", "completada": false},
	"4": {"nombre": "Bossfight", "descripcion": "El pejelagarto ha llegado, ayuda a los habitantes a deshacerse de el", "completada": false},
}

#Oculta al boss y al lineedit de las respuestas de la trivia
func _ready():
	$"../miniBoss".visible = false
	$"../respuesta".visible = false
	$"../michicaja".play("Box")
	$"../michi".play("Idle")
#Revisa constantemente si se entró a las areas de cada mision
#en caso de que se haya entrado y se presione la tecla correspondiente inicia el minijuego
func _process(delta):
	if $"../NPCPesca".inside and Input.is_action_just_pressed("ui_cancel") and !pesca:
		pesca = true
		clicks = 0
	if areaP and Input.is_action_just_pressed("ui_accept") and pesca:
		if clicks == 0:
			pescar(completados)
	if activo and pesca:
		if Input.is_action_just_pressed("ui_accept"):
			clicks += 1
			print(clicks)
	if $"../NPCCajas".inside and Input.is_action_just_pressed("ui_cancel"):
		if !misiones["2"]["completada"]:
			cajas = true
	if Input.is_action_just_pressed("ui_accept") and cajas and dentro:
		print("encontraste la caja correcta")
		busqueda()
	if $"../NPCTrivia".inside and Input.is_action_just_pressed("ui_cancel"):
		$"../respuesta".visible = true
		Trivia = true
	if Trivia:
		var pregunta = preguntas["Nivel"+str(contador)][str(completados)]
		$"../respuesta".placeholder_text = pregunta
		var bien
		if Input.is_action_just_pressed("ui_cancel") and $"../respuesta".visible == true:
			respuesta = $"../respuesta".text
			bien = responder(preguntas, respuesta, correcta["Nivel"+str(contador)][str(completados)])
		
		if bien == true:
			revision["Nivel"+str(contador)][str(completados)] = true
			completados += 1
			bien = false
		if completados > 3 and contador < 3:
			completados = 1
			contador += 1
		elif completados > 3 and contador == 3:
			trivia()


func pescar(completada):
	if completados == 0:
		print("El jugador esta pescando")
		print("Preparate, para poder pescar la comida hay que presionar multiples veces la tecla enter, lo mas rapido posible")
		$"../Timer".wait_time = 5.0
		$"../Timer".one_shot = true
		$"../Timer".start()
		activo = true
	elif completados > 0 and completados < 3:
		print("Round: ", completados+1)
		$"../Timer".wait_time = 5.0
		$"../Timer".one_shot = true
		$"../Timer".start()
		activo = true
	else:
		print("Felicidades, pescaste suficiente comida para los gatos, ahora ve con el X para entregarla")
		misiones["1"]["completada"] = true
		completados = 1
	

func busqueda():
	misiones["2"]["completada"] = true
	print(misiones)
	cajas = false


func trivia():
	if revision["Nivel3"]["3"] == true:
		misiones["3"]["completada"] = true
		Trivia = false
		print(misiones)
	

func responder(pregunta, respuesta, correcta):
	if respuesta == correcta:
		print("correcto")
		#marcar la clave de la respuesta como correcta
		return true
	else:
		print("Incorrecto")



func bossfight():
	var completadas = 0
	for i in misiones:
		if misiones[i]["completada"] == true:
			completadas += 1
	if completadas == 3:
		$"../miniBoss".visible = true
		print("puedes luchar contra el boss")
		#permitir el acceso a la bossfight y mandar a la escena de combate

#Cuando se acaba el tiempo se revisa la cantidad de clicks
#y se dice si se ganó o perdió
func _on_timer_timeout():
	activo = false
	#Nivel 1: Facil
	if clicks >= 30 and completados == 0:
		print("ganaste")
		completados += 1
		clicks = 0
	elif clicks < 30 and $"../Timer".is_stopped() == true:
		print("perdiste")
		clicks = 0
	#Nivel 2: Medio
	elif clicks >= 35 and completados == 1:
		print("ganaste")
		completados += 1
		clicks = 0
	elif clicks < 35 and completados == 1:
		print("perdiste")
		clicks = 0
	#Nivel 3: Dificil
	elif clicks >= 36 and completados == 2:
		print("ganaste el minijuego completo")
		completados += 1
		pescar(completados)
	elif clicks < 36 and completados == 2:
		print("perdiste")
		clicks = 0


func _on_area_2d_area_entered(area: Area2D):
	areaP = true


func _on_caja_area_entered(area: Area2D):
	dentro = true
