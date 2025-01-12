extends CharacterBody2D

func npc(dialogue = false, friendly = true, icon = "res://icon.svg"):
	pass
	
var dialogue = ["Hello, how are you?", "Hey"]

func Show_textbox():
	
	if %Event.area_entered and Input.is_action_just_pressed("ui_cancel") and len(%Textbox.text_queue) == 0 and len(dialogue) != 0:
		%Textboxsfx.play()
		for index in range(len(dialogue)):
			%Textbox.dialogue(dialogue[index])
		%Textbox.show_textbox()
		
func _process(delta):
	Show_textbox()
		
func _physics_process(delta):
	
	move_and_slide()
