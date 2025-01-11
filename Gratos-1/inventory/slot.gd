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

		# Si el usuario desea vaciar un slot debe seleccionar uno, esto activara al botón y si presiona backspace se botara el objeto al mapa
		if active and Input.is_action_just_pressed("delete") and item["id"] != null: # por supuesto el slot debe estar lleno
			var map = get_parent().get_parent().get_parent().get_parent() # obtenemos al mapa ( si se puede hacer mejoralo)
			var player = get_parent().get_parent().get_parent() # se obtiene el nodo del jugador
			var dropitem = preload("res://inventory/items/item1.tscn").instantiate() # se instancia un item nuevo para vacial el slot
			dropitem.image = $Button.icon # se le coloca la misma imagen 
			dropitem.id_item = item["id"] # Y también el mismo ID y sus caracteristicas
			dropitem.get_child(0).text = $Button.get_child(0).text # le colocamos la misma cantidad de items que tenga en el inventario
			dropitem.position = Vector2(player.position[0] + 10, player.position[1] + 10) # se ubica a la esquina derecha del player
			map.add_child(dropitem) # se añade el item al mapa
			# Se limpia el slot y después se desactiva el boton
			$Button.icon = null 
			item = {"id": null}
			$Button.get_child(0).text = ""
			$Button.release_focus()
			$Button.queue_redraw()
			active = false
			
		# Si el usuario solo desea soltar un objeto solo debe presionar q con el boton activado	
		elif active and Input.is_action_just_pressed("soltar") and item["id"] != null:
			var map = get_parent().get_parent().get_parent().get_parent() 
			var player = get_parent().get_parent().get_parent()
			var dropitem = preload("res://inventory/items/item1.tscn").instantiate()
			dropitem.image = $Button.icon 
			dropitem.id_item = item["id"]
			dropitem.get_child(0).text = ""
			dropitem.position = Vector2(player.position[0] + 10, player.position[1] + 10)
			map.add_child(dropitem)
			# El proceso es el mismo solo que en este caso el objeto es instanciado uno a uno y se le va restando del inventario solo que si se queda sin ese obejtos se vacia el slot
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
				
		# Para el uso del item se conserva la misma logica del anterior con la diferencia que este modificara las stats del jugador
		elif active and Input.is_action_just_pressed("usar") and item["id"] == 2:
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

# Si el botón es activado los demás serán desactivados
func _on_button_button_up() -> void:
	for i in get_parent().get_children():
		i.active = false
	active = true
	

# Si un atajo es cliqueado el botón es activado y los demás desactivados
func _on_button_pressed() -> void:
	for i in get_parent().get_children():
		i.active = false
	active = true
	$Button.grab_focus()
	
