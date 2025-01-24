extends CharacterBody2D

var inside = false

func _ready():
	if $Sprite is AnimatedSprite2D:
		$Sprite.play()
		
func Show_textbox():
	if inside and Input.is_action_just_pressed("ui_cancel") and len(%Textbox.text_queue) == 0 and len(%Node2D.resource.Dialogue) != 0:
		%Textboxsfx.play()
		for index in range(len(%Node2D.resource.Dialogue)):
			%Textbox.dialogue(%Node2D.resource.Dialogue[index])
		%Textbox.show_textbox()

#Funcion que pausa la escena del mapa correspondiente e instancia
#una de combate
func fight():
	get_tree().change_scene_to_file("res://Combat/Combat maps/Basico_combate.tscn")
	
	$"..".visible = false
	get_tree().paused = true

	
func _process(delta):
	if %Node2D.resource.Friendly:
		Show_textbox()
			
		
func _physics_process(delta):
	move_and_slide()

func _on_event_area_entered(area):
	if %Node2D.resource.Friendly:
		inside = true
	else:
		fight()

func _on_event_area_exited(area):
	inside = false 
