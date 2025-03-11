extends Node2D
@export var map: PackedScene
@export var new_x:float
@export var new_y:float

	
var inside = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(map)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):	
		var new_map = load(map.get_path()).instantiate()
		new_map.RPG_character = load("res://Characters/PLayable characters/RPG_character.tscn")
		Manager.player_last_position = Vector2(new_x,new_y)
		get_parent().get_parent().add_child(new_map)
		#print(get_parent().get_parent().get_path())
		get_parent().queue_free()
		inside = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	inside = false
