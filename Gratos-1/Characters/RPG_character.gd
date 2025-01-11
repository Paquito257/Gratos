extends CharacterBody2D

@export var mov_speed: float
func _ready():
	pass
	set_multiplayer_authority(name.to_int())

func _physics_process(delta):
	if is_multiplayer_authority(): 
		$inventario.visible = true # Esto es para que el inventario solo sea visible por el propietario
		var directionx = Input.get_axis("ui_left", "ui_right")
		var directiony = Input.get_axis("ui_up","ui_down")

		if directionx != 0:
			velocity.x = directionx *  mov_speed
		else:
			velocity.x = move_toward(velocity.x, 0, 128)
			
		if directiony != 0:
			velocity.y = directiony * mov_speed
		else:
			velocity.y = move_toward(velocity.y, 0, 128)
		
		move_and_slide()
	else: 
		$inventario.visible = false # Aqui se oculta para que los oros players no lo vean
		
