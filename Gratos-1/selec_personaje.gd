extends Control

@onready var animacion = $AnimationPlayer
@onready var texto = $Label
var personajes = PlayerHandle.characters
var tamaño = PlayerHandle.players.size()
var posibilidades = [["caballero", "barbaro"], ["caballero", "arquero"], ["caballero", "mago"], ["barbaro", "arquero"], ["barbaro", "mago"], ["arquero", "mago"]]
var contador = 0

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
		#for i in PlayerHandle.players:
			#if get_tree().get_network_unique_id() == PlayerHandle.players[i].id:
				#PlayerHandle.players[i].character =

		animacion.stop()
		PlayerHandle.players[multiplayer.get_unique_id()].character = "caballero"		
		deshabilitar.rpc(1)


		print(PlayerHandle.players[multiplayer.get_unique_id()])
				
	elif animacion.get_current_animation() == "selection2":
		animacion.stop()
		PlayerHandle.players[multiplayer.get_unique_id()].character = "barbaro"
		deshabilitar.rpc(2)

				
	elif animacion.get_current_animation() == "selection3":
		animacion.stop()
		PlayerHandle.players[multiplayer.get_unique_id()].character = "arquero"
		deshabilitar.rpc(3)

				
	elif animacion.get_current_animation() == "selection4":
		animacion.stop()
		PlayerHandle.players[multiplayer.get_unique_id()].character = "mago"
		deshabilitar.rpc(4)

		

#Detiene la animación de confirmación para poder seleccionar otro personaje
func _on_no_pressed():
	animacion.stop()
#COLOCAR QUE SE AÑADAN LOS PERSONAJES EN BASE A LA LISTA
#A VER SI ASI LOS AÑADE BIEN

#deshabilita los personajes seleccionados y
#añade a una lista los personajes seleccionados
@rpc("any_peer", "call_local")
func deshabilitar(nro):
	if nro == 1:
		$Personaje1.disabled = true
		personajes.append("caballero")
		$Personaje1/Knight.show_behind_parent = true
		revision()
	elif nro == 2:
		$Personaje2.disabled = true
		personajes.append("barbaro")
		$Personaje2/Barbarian.show_behind_parent = true
		revision()
	elif nro == 3:
		$Personaje3.disabled = true
		personajes.append("arquero")
		$Personaje3/Archer.show_behind_parent = true
		revision()
	elif nro == 4:
		$Personaje4.disabled = true
		personajes.append("mago")
		$Personaje4/Wizard.show_behind_parent = true
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
	for i in PlayerHandle.ids:
		if PlayerHandle.players[i].character != null:
			contador += 1
		elif PlayerHandle.players[i].character == null:
			PlayerHandle.players[i].character = personajes[contador]
	for i in posibilidades:
		if i[0] in grupo and i[1] in grupo:
			return true
	return false
	
