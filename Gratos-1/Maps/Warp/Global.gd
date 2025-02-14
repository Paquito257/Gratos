extends Node2D

@export_file("*.tscn") var arena 
var reaady = false
var battle_scene = false
var encounter : int = 30:
	set(value):
		encounter = value
		
var enemy_cache : Dictionary = {}

var enemy_appearence = {
	"Basico" : ["000","001"]
}
		
var player_last_position : Vector2 = Vector2(0,0)

func _ready():
	randomize()
	encounter = randi_range(25,50)
	
func change_to_battle():
	get_tree().change_scene_to_file(arena)

func save_data(player):
	player_last_position = player.position
	
func load_enemies(ene):
	pass
