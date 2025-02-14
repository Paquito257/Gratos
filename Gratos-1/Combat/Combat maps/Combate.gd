extends Node2D

@onready var menu = $CanvasLayer
func turn():
	pass
	
func _ready():
	Music.change_track(Music.enemigo, Music.hub)
	character_spawn()
	menu.world = "res://Maps/Test_map.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turn()
	
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

	add_child(player)
	player.position = $"Players/1".position
	player.play("Idle")
	
