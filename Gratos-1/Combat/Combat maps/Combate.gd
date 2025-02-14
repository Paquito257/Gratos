extends Node2D

@onready var menu = $CanvasLayer
 #Accede a la carpeta donde se encuentran los enemigos
var files_in_directory = DirAccess.get_files_at("res://Characters/Battle enemies/Scripts/")

var enemies = []
var players = []
	
func _ready():
	Music.change_track(Music.enemigo, Music.hub)
	character_spawn()
	spawn_enemies()
	menu.world = "res://Maps/Test_map.tscn"


#Permite seleccionar a uno de los oponentes para atacar
#en el caso de que el ataque no sea multiple
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		pass
	elif Input.is_action_just_pressed("ui_down"):
		pass
		
func character_spawn():
	var player
	match PlayerHandle.players[multiplayer.get_unique_id()].character:
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
	player.position = $"Players/1".position
	player.play("Idle")
	
#TODO: esta funcion deberia ir dentro de global, y depende
#(la aparicion) del area donde se encuentra el jugador
func spawn_enemies():
	var random_enemy
	var enemy
	var random = randi_range(1,3)
	print(random)
	for i in random:
		
		print(i)
		random_enemy = files_in_directory[randi() % files_in_directory.size()]
		print(random_enemy)
		enemy = load("res://Characters/Battle enemies/Scripts/" + random_enemy).instantiate()
		enemies.append(enemy)
		add_child(enemies[i])
		match i:
			0:
				enemies[i].position = $"Enemies/1".position
				enemies[i].animation.play()
			1:
				enemies[i].position = $"Enemies/2".position
				enemies[i].animation.play()
			2:
				enemies[i].position = $"Enemies/3".position
				enemies[i].animation.play()

func focus(global):
	pass

func switch_focus():
	pass
