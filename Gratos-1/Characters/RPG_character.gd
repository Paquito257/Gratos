extends CharacterBody2D

func _ready():
	set_multiplayer_authority(name.to_int())

func _physics_process(delta):
	if is_multiplayer_authority(): 
		var directionx = Input.get_axis("ui_left", "ui_right")
		var directiony = Input.get_axis("ui_up","ui_down")

		if directionx:
			velocity.x = directionx*128 
		else:
			velocity.x = move_toward(velocity.x, 0, 128)
			
		if directiony:
			velocity.y = directiony *128
		else:
			velocity.y = move_toward(velocity.y, 0, 128)
		
		move_and_slide()




