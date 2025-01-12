extends CanvasLayer

@onready var menu = %Basic_menu
@onready var combat = %Combat
@onready var item = %Item
@onready var special = %Special
var selected = false
var hypothetical_skills = ["Golpe","Patada","Estocada","Corte"]

func menup():	
	for node in get_tree().get_nodes_in_group("Menus"):
		if node.name != "Basic_menu":
			if Input.is_action_just_pressed("ui_cancel") and node.visible:
				print(1)
				menu.visible = true
				node.visible = false
	
func _ready():
	for i in len(hypothetical_skills):
		combat.add_item(hypothetical_skills[i])
		item.add_item(hypothetical_skills[i])
		special.add_item(hypothetical_skills[i])



func _process(delta):
	menup()
	


func _on_basic_menu_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_LEFT:	
		match index:
			0:
				%Sfx.play()
				menu.visible = false
				combat.visible = true
			1:
				%Sfx.play()
				menu.visible = false
				item.visible = true
			2:
				%Sfx.play()
				menu.visible = false
				special.visible = true
			3:
				pass
				
		
		
