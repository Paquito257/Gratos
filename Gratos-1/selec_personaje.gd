extends Control

@onready var animacion = $AnimationPlayer
@onready var texto = $Label
var personajes = PlayerHandle.characters
var tamaño = PlayerHandle.players.size()
var posibilidades = [["Personaje1", "Personaje2"], ["Personaje1", "Personaje3"], ["Personaje1", "Personaje4"], ["Personaje2", "Personaje3"], ["Personaje2", "Personaje4"], ["Personaje3", "Personaje4"]]

#Si se presiona el personaje se oculta el texto previo
#e inicia la animación para confirmar la selección
func _on_personaje_1_pressed():
	texto.hide()
	animacion.play("selection1")

func _on_personaje_2_pressed():
	texto.hide()
	animacion.play("selection2")

func _on_personaje_3_pressed():
	texto.hide()
	animacion.play("selection3")
	
func _on_personaje_4_pressed():
	texto.hide()
	animacion.play("selection4")

#Detiene la animación de confirmación y llama a la funcion de deshabilitar
#los personajes seleccionados
func _on_si_pressed():
	if animacion.get_current_animation() == "selection1":
		animacion.stop()
		deshabilitar.rpc(1)
	elif animacion.get_current_animation() == "selection2":
		animacion.stop()
		deshabilitar.rpc(2)
	elif animacion.get_current_animation() == "selection3":
		animacion.stop()
		deshabilitar.rpc(3)
	elif animacion.get_current_animation() == "selection4":
		animacion.stop()
		deshabilitar.rpc(4)

#Detiene la animación de confirmación para poder seleccionar otro personaje
func _on_no_pressed():
	animacion.stop()


#deshabilita los personajes seleccionados y
#añade a una lista los personajes seleccionados
@rpc("any_peer", "call_local")
func deshabilitar(nro):
	print("1343435254sda")
	print(personajes)
	if nro == 1:
		$Personaje1.disabled = true
		personajes.append("Personaje1")
		revision()
	elif nro == 2:
		$Personaje2.disabled = true
		personajes.append("Personaje2")
		revision()
	elif nro == 3:
		$Personaje3.disabled = true
		personajes.append("Personaje3")
		revision()
	elif nro == 4:
		$Personaje4.disabled = true
		personajes.append("Personaje4")
		revision()
		

#comprueba el tamaño del diccionario para saber la cantidad de jugadores
#en caso de ser uno, pasa al juego, en caso de ser dos
#revisa la lista para verificar que ambos jugadores hayan escogido personaje
#si se cumple, avanza y muestra el juego
func revision():
	var cantidad = personajes.size()
	if tamaño == 1:
		var game = load("res://Maps/Test_map.tscn").instantiate()
		get_tree().root.add_child(game)
		$".".visible = false
	else:
		if cantidad >= 2 and comprobar(personajes, posibilidades):
			var game = load("res://Maps/Test_map.tscn").instantiate()
			get_tree().root.add_child(game)
			$".".visible = false

func comprobar(grupo, posibilidades):
	for i in posibilidades:
		if i[0] in grupo and i[1] in grupo:
			return true
	return false
	
