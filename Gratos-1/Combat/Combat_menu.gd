extends CanvasLayer


@onready var menu = %Basic_menu
@onready var combat = %Combat
@onready var special = %Item
@onready var item = %Special
#var player = PlayerHandle.players[multiplayer.get_unique_id()]
@export_file("*.tscn") var world 

var hypothetical_skills = ["Golpe","Patada","Estocada","Corte"]

func menup():	
	for node in get_tree().get_nodes_in_group("Menus"):
		if node.name != "Basic_menu":
			if Input.is_action_just_pressed("ui_cancel") and node.visible:
				menu.visible = true
				node.visible = false
	
func _ready():
	for i in len(PlayerHandle.players[multiplayer.get_unique_id()].skills):
		if PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Magic == 0:
			combat.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)
			item.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)
		else:
			special.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)



func _process(delta):
	menup()

#Muestra una lista correspondiente a la accion seleccionada
func _on_basic_menu_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_LEFT:	
		match index:
			0: #Muestra los ataques normales
				%Sfx.play()
				menu.visible = false
				combat.visible = true
			1: #Muestra los ataques magicos
				%Sfx.play()
				menu.visible = false
				special.visible = true
			2: #Muestra los objetos
				%Sfx.play()
				menu.visible = false
				item.visible = true
			3: #Permite huir del combate
				%Sfx.play()
				$"Container Alpha".visible = false
				$Textbox.dialogue("Escape exitoso")
				$Textbox.show_textbox()
				get_tree().create_timer(1)
				if len($Textbox.text_queue) == 0:
					Music.enemigo.stop()
					get_tree().change_scene_to_file(world)
					


#Permite seleccionar los ataques normales
#(y que estos tengan efecto en el combate)
func _on_combat_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		for skill in PlayerHandle.players[multiplayer.get_unique_id()].skills:
			if combat.get_item_text(index) == skill.Skill_name:
				%Sfx.play()
	
			


#Permite seleccionar los items
#(y que estos tengan efecto en el combate)
func _on_item_item_clicked(index, at_position, mouse_button_index):
	pass # Replace with function body.
