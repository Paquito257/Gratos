extends Node2D

@export var  RPG_character : PackedScene
var camera_pos 

#Crea instancias de los personajes jugables correspondiente al 
#numero de jugadores
func _ready():

	Music.hub.play()

	for i in PlayerHandle.players:
		var current_player = RPG_character.instantiate()
		current_player.name = str(PlayerHandle.players[i].id)
		
		#Esta linea añade las skills al personaje
		#TODO: Personalizarlo para cada clase/jugador
		PlayerHandle.players[i].skills = current_player.attacks.duplicate()
		add_child(current_player)
		
				
		for spawn in get_tree().get_nodes_in_group("Spawnpoint"):
			if spawn.name == str(PlayerHandle.index):	
				print(PlayerHandle.index)

				current_player.global_position = spawn.global_position
				#PlayerHandle.players[i].instance = current_player
				

				
		PlayerHandle.index += 1
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
