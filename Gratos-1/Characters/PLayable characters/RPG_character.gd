extends CharacterBody2D

#Variables que se mostraran en el inspector del nodo correspondiente
#al personaje
@export_category("Player settings")
@export_enum("caballero","mago", "arquero","barbaro") var clase = "mago"
@export var nivel:int = 1
@export var attacks : Array[Resource] 
@onready var camera = $Camera2D

var mov_speed = 150
var animation = Resource

func _ready():
	character_sprite()
	add_child(animation)
	var stats = load("res://stats/stats.tscn").instantiate()
	add_child(stats)
	
	animation.play("Idle")
	GameControl.global_camera_position= camera.position
	GameControl.current_map = get_tree().current_scene.name
	print(GameControl.current_map + "hello everybody")
	set_multiplayer_authority(name.to_int())


func _physics_process(delta):
	if is_multiplayer_authority(): #GameControl.current_map.visible == true
		$Stats.visible = true
		$inventario.visible = true # Esto es para que el inventario solo sea visible por el propietario

		var direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
		if direction:
			animation.play("Walk")
			
			if direction.x > 0:
				animation.flip_h = false
					
			elif direction.x < 0:
				animation.flip_h = true
		
		else:
			animation.play("Idle")
			
		velocity = direction * mov_speed
		
		move_and_slide()
	else: 
		$Stats.visible = false
		$inventario.visible = false# Aqui se oculta para que los otros players no lo vean
		camera.enabled = false

func character_sprite():
	match PlayerHandle.players[multiplayer.get_unique_id()].character:
		"caballero":
			animation = load("res://Characters/PLayable characters/Scenes/Knight.tscn").instantiate()
			clase = "caballero"
		"arquero":
			animation = load("res://Characters/PLayable characters/Scenes/Archer.tscn").instantiate()
			clase = "arquero"
		"barbaro":
			animation = load("res://Characters/PLayable characters/Scenes/Barbarian.tscn").instantiate()
			clase = "barbaro"
		"mago":
			animation = load("res://Characters/PLayable characters/Scenes/Wizard.tscn").instantiate()
			clase = "mago"
		
