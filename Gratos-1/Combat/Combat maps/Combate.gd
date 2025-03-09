extends Node2D

#El fin se acerca
@onready var menu = $CanvasLayer
var index: int = 0
var selection = []
#Accede a la carpeta donde se encuentran los enemigos
var files_in_directory = DirAccess.get_files_at("res://Characters/Battle enemies/Scripts/")

#Arreglos que contienen a los enemigos y jugadores
var turn_order = []
var enemies = []
var players = []
var enemy_n = 1
	
func _ready():
	Music.change_track(Music.enemigo, Music.hub)
	character_spawn()
	enemy_n = spawn_enemies()
	
	#Crea una mano de selección (para los ataques) por cada enemigo
	for select in enemy_n:
		selection.append(Sprite2D.new())
		selection[select].texture = load("res://Characters/Misc/finger.png")
		selection[select].scale = Vector2(0.09, 0.09)
		selection[select].position = Vector2(enemies[select].position.x - 25, enemies[select].position.y) 

		$".".add_child(selection[select])
		
		selection[select].hide()

#Permite seleccionar a uno de los oponentes para atacar
#en el caso de que el ataque no sea multiple
func _process(delta):
	pass
		
func character_spawn():
	var player
	var n = 0
	#Verifica la clase del jugador/jugadores, e instancia la correspondiente
	for p in PlayerHandle.players:
		match PlayerHandle.players[p].character:
			"caballero":
				player = load("res://Characters/PLayable characters/Scenes/Knight.tscn").instantiate()

			"arquero":
				player = load("res://Characters/PLayable characters/Scenes/Archer.tscn").instantiate()
				
			"barbaro":
				player = load("res://Characters/PLayable characters/Scenes/Barbarian.tscn").instantiate()

			"mago":
				player = load("res://Characters/PLayable characters/Scenes/Wizard.tscn").instantiate()

		players.append(player)
		add_child(player)
		players[n].position = $"Players/1".position 
		players[n].play("Idle")
		
		n +=1
	
	order()
	
#TODO: esta funcion deberia ir dentro de global, y depende
#(la aparicion) del area donde se encuentra el jugador
func spawn_enemies():
	var random_enemy
	var enemy
	var random = randi_range(1,3)
	
	for i in random:
		
		random_enemy = files_in_directory[randi() % files_in_directory.size()]
		print(random_enemy)
		enemy = load("res://Characters/Battle enemies/Scripts/" + random_enemy).instantiate()
		enemies.append(enemy)
		add_child(enemies[i])
		match i:
			0:
				enemies[i].position = $"Enemies/0".position 

			1:
				enemies[i].position = $"Enemies/1".position

			2:
				enemies[i].position = $"Enemies/2".position
	
	return random

#Selecciona a un enemigo/aliado (o a todos, si es un ataque multiple)
func enemy_selection():
	#Cambia el target del ataque
	if Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
			switch_focus(selection[index], selection[index + 1])
	elif Input.is_action_just_pressed("ui_down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(selection[index], selection[index - 1])
			
	attack_confirmation(enemies[index])

#Cambia el focus a otro enemigo seleccionado
func switch_focus(x,y):
	x.show()
	y.hide()
	Music.select.play()
	
#Confirma el ataque a enemigo seleccionado
func attack_confirmation(target):
	if Input.is_action_just_pressed("ui_text_submit"):
		print("yes")
		DamageModifiers.dmg_calculator( PlayerHandle.players[multiplayer.get_unique_id()].stats,enemies[index].stats,menu.current_skill, players[0].nivel)
		enemies[index].update_stats()
#Establece el orden de turnos
func order():
	pass
	
#Funcion para usar como Callable y arreglar el orden de turnos
func sort_descending(a, b):
	if a[1] > b[1]:
		return true
	return false
