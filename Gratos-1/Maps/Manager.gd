extends Node2D

@export var RPG_character : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in PlayerHandle.players:
		var current_player = RPG_character.instantiate()
		current_player.name = str(PlayerHandle.players[i].id)
		add_child(current_player)
				
		for spawn in get_tree().get_nodes_in_group("Spawnpoint"):
			if spawn.name == str(PlayerHandle.index):
				print(spawn.global_position)
				current_player.global_position = spawn.global_position
				print(current_player.global_position)
				
				
				PlayerHandle.index += 1
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
