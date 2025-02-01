extends CharacterBody2D

#Variables que se mostraran en el inspector del nodo correspondiente
#al personaje
@export_category("Player settings")
@export var mov_speed: float
@export_enum("arquero", "mago", "caballero", "barbaro") var clase: String = "caballero"
@export var nivel:int = 1
@export var attacks : Array[Resource] 
@onready var camera = $Camera2D

func _ready():
	GameControl.global_camera_position= camera.position
	GameControl.current_map = get_tree().current_scene.name
	print(GameControl.current_map + "hello everybody")
	set_multiplayer_authority(name.to_int())


func _physics_process(delta):
	if is_multiplayer_authority(): #GameControl.current_map.visible == true
		$Stats.visible = true
		$inventario.visible = true # Esto es para que el inventario solo sea visible por el propietario

		var direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
		print(direction)
		velocity = direction * mov_speed
		
		move_and_slide()
	else: 
		$Stats.visible = false
		$inventario.visible = false# Aqui se oculta para que los otros players no lo vean
		camera.enabled = false
