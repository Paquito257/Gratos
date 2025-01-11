extends Panel
var item = {"id": null}
var active = false
#var slot = ""
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#slot = $"."
	#pass # Replace with function body.

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	
		if active and Input.is_action_just_pressed("delete") and item["id"] != null:
			var map = get_parent().get_parent().get_parent().get_parent()
			var player = get_parent().get_parent().get_parent()
			var dropitem = preload("res://inventory/items/item1.tscn").instantiate()
			dropitem.image = $Button.icon 
			dropitem.id_item = item["id"]
			dropitem.get_child(0).text = $Button.get_child(0).text
			dropitem.position = Vector2(player.position[0] + 10, player.position[1] + 10)
			map.add_child(dropitem)
			$Button.icon = null
			item = {"id": null}
			$Button.get_child(0).text = ""
			$Button.release_focus()
			$Button.queue_redraw()
			active = false
			
			
		elif active and Input.is_action_just_pressed("soltar") and item["id"] != null:
			var map = get_parent().get_parent().get_parent().get_parent()
			var player = get_parent().get_parent().get_parent()
			var dropitem = preload("res://inventory/items/item1.tscn").instantiate()
			dropitem.image = $Button.icon 
			dropitem.id_item = item["id"]
			dropitem.get_child(0).text = ""
			dropitem.position = Vector2(player.position[0] + 10, player.position[1] + 10)
			map.add_child(dropitem)
			if $Button.get_child(0).text.to_int() - 1 == 1:
				$Button.get_child(0).text = ""
				$Button.queue_redraw()
			elif ($Button.get_child(0).text.to_int() - 1 < 1):
				$Button.icon = null
				item = {"id": null}
				$Button.get_child(0).text = ""
				$Button.queue_redraw()
				$Button.release_focus()
				active = false
			else:
				$Button.get_child(0).text = str($Button.get_child(0).text.to_int() - 1)
				$Button.queue_redraw()
				
				
		elif active and Input.is_action_just_pressed("use") and item["id"] == 2:
			pass

func _on_button_button_up() -> void:
	for i in get_parent().get_children():
		i.active = false
	active = true
	


func _on_button_pressed() -> void:
	for i in get_parent().get_children():
		i.active = false
	active = true
	$Button.grab_focus()
	
