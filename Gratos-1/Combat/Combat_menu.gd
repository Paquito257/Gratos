extends CanvasLayer


@onready var menu = %Basic_menu
@onready var combat = %Combat
@onready var item = %Item
@onready var special = %Special

var current_menu : String
var current_skill 

func menup():	
	for node in get_tree().get_nodes_in_group("Menus"):
		if node.name != "Basic_menu":
			if Input.is_action_just_pressed("ui_cancel") and node.visible:
				menu.visible = true
				node.visible = false
			
			elif !node.visible and Input.is_action_just_pressed("ui_cancel") and current_menu == node.name:
					for select in get_parent().selection:
						select.hide()
					node.show()
					
			elif !node.visible and current_menu == node.name:
				get_parent().enemy_selection(current_skill.Global)
				
			
				
			
func _ready():
	current_menu = menu.name
	add_items()


func _process(delta):
	menup()

#Muestra una lista correspondiente a la accion seleccionada
func _on_basic_menu_item_clicked(index, at_position, mouse_button_index):
	current_menu = menu.name
	if mouse_button_index == MOUSE_BUTTON_LEFT:	
		match index:
			0: #Muestra los ataques normales
				Music.select.play()
				menu.visible = false
				combat.visible = true
				current_menu = combat.name
			1: #Muestra los ataques magicos
				Music.select.play()
				menu.visible = false
				special.visible = true
				current_menu = special.name
			2: #Muestra los objetos
				Music.select.play()
				menu.visible = false
				item.visible = true
				current_menu = item.name
			3: #Permite huir del combate
				if Manager.boss != true:
					Music.select.play()
					$"Container Alpha".visible = false
					$Textbox.dialogue("Escape exitoso")
					$Textbox.show_textbox()
					get_tree().create_timer(1)
					if len($Textbox.text_queue) == 0:
						Music.enemigo.stop()
						#get_tree().change_scene_to_file(world)
						Manager.change_to(get_parent().get_tree().root, "Combate")
				else: 
					pass
					


#Permite seleccionar los ataques normales
#(y que estos tengan efecto en el combate)
func _on_combat_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		for skill in PlayerHandle.players[multiplayer.get_unique_id()].skills:
			if combat.get_item_text(index) == skill.Skill_name:
				Music.select.play()
				get_parent().selection[get_parent().index].show()
				combat.visible = false
				current_skill = skill


#Permite seleccionar los items
#(y que estos tengan efecto en el combate)
func _on_item_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		for skill in PlayerHandle.players[multiplayer.get_unique_id()].skills:
			if combat.get_item_text(index) == skill.Skill_name:
				Music.select.play()
				

#Permite seleccionar los ataques especiales
#(y que estos tengan efecto en el combate)
func _on_special_item_clicked(index, at_position, mouse_button_index):
	var current_magic = PlayerHandle.players[multiplayer.get_unique_id()].stats.magia
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		for skill in PlayerHandle.players[multiplayer.get_unique_id()].skills:
			if special.get_item_text(index) == skill.Skill_name:
				
				if current_magic >= skill.Magic:
					Music.select.play()
					get_parent().selection[get_parent().index].show()
					special.visible = false
					current_skill = skill
				
				else:
					Music.invalid.play()
				
func add_items():
	for i in len(PlayerHandle.players[multiplayer.get_unique_id()].skills):
		if PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Magic == 0:
			combat.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)
			item.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)
		else:
			special.add_item(PlayerHandle.players[multiplayer.get_unique_id()].skills[i].Skill_name)
	
