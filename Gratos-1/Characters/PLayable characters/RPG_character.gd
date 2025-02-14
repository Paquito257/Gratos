extends CharacterBody2D

#Variables que se mostraran en el inspector del nodo correspondiente
#al personaje
@export_category("Player settings")
@export_enum("caballero","mago", "arquero","barbaro") var clase = "mago"
@export var nivel:int = 1
@export var attacks : Array[Resource] 

@onready var camera = $Camera2D

var mov_speed = 150
var distance_traveled = mov_speed/2 
var animation = Resource

#Con esta variable, se calcula el movimiento total en pixeles
#y en el mapa, para la aparicion de enemigos
var step_pixel : float = 0.0:
	set(value):
		step_pixel = value
		var step = step_pixel/distance_traveled

		if step >= Manager.encounter:
			set_physics_process(false)
			Manager.save_data(self)
			$Stats.visible = false
			$inventario.visible = false
			camera.enabled = false
			Manager.change_to_battle()

			step = 0
			
		
func _ready():
	
	character_sprite()
	position = Manager.player_last_position
	add_child(animation)
	var stats = load("res://stats/stats.tscn").instantiate()
	add_child(stats)
	
	animation.play("Idle")
	set_multiplayer_authority(name.to_int())


func _physics_process(delta):
	var initial = position

	if is_multiplayer_authority() and is_physics_processing():
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
		step_pixel += position.distance_to(initial) #Suma los pixeles movidos
		
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
		
