extends CharacterBody2D

func Show_textbox():
	
	if  Input.is_action_just_pressed("ui_cancel") and len(%Textbox.text_queue) == 0 and len(%Node2D.resource.Dialogue) != 0:
		%Textboxsfx.play()
		for index in range(len(%Node2D.resource.Dialogue)):
			%Textbox.dialogue(%Node2D.resource.Dialogue[index])
		%Textbox.show_textbox()
		
func _process(delta):
	Show_textbox()
		
func _physics_process(delta):
	move_and_slide()

