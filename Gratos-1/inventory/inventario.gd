extends CanvasLayer

var items = ["sword"]

# Called when the node enters the scene tree for the first time.
@export var item_scene : PackedScene
func _ready() -> void:
	get_tree().get_root().get_node("/root/Map")
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_time_timeout() -> void:
	$Warning.text = ""
	$Warning.queue_redraw()
	$bg.visible = false



func _on_time_2_timeout() -> void:
	$Election.visible = false
	$Election.active = false
	$bg.visible = false
	$Election/new.icon = null
	$Election/old.icon = null
	
func warning(entry:String):
	$bg.visible = true
	$Warning.text = entry
	$Warning.queue_redraw()
	$time.start()
	

func show_election():
	$Election.visible = true
	$bg.visible = true

func check_for_empty_slot():
	for i in $GridContainer.get_children():
		var btn = i.get_child(0)
		if btn.icon == null:
			return btn
	warning("Sin espacio en el inventario")
	return null

func find_similar_object(obj:Node):
	for i in $GridContainer.get_children():
		var btn = i.get_child(0)
		if btn.icon == null: continue
		if obj.image.get_path() == btn.icon.get_path():
			if obj.item['tipo'] == 1:
				# se hace visible el panel para la elección
				show_election()
				# se obtienen los nodos que se mostraran para que el usuario elija
				$Election/new.icon = obj.image
				$Election/old.icon = btn.icon
				# Se envian al script del panel para realizar el cambio
				$Election.emit_signal("election",btn,obj)
				$time2.start()
				return true
			else: 
				if btn.get_child(0).text == "": 
					if obj.get_child(0).text.to_int() == 0: # Si se encontro un elemento igual y este no tiene mas de dos items en el inventario ni en el mapa se suma 1 + 2 = 2
						btn.get_child(0).text = str(1 + 1) # Aqui simplemente se actualiza el label que tiene el boton
						btn.get_child(0).queue_redraw()
						obj.queue_free()
					else: # Si el elemento a recoger tiene más de uno la suma de los item sera 1 + n, donde n es el número de items que hay en el stack del suelo
						btn.get_child(0).text = str(1 + obj.get_child(0).text.to_int())
						btn.get_child(0).queue_redraw()
						obj.queue_free() # eliminamos el item del suelo
				else: 
					if obj.get_child(0).text.to_int() == 0: # Como el objeto encontrado en el invetario tiene n elementos se suma n + 1, ya que el del suelo solo tiene 1
						btn.get_child(0).text = str(btn.get_child(0).text.to_int() + 1)
						btn.get_child(0).queue_redraw()
						obj.queue_free()
					else: # Si el objeto del suelo es un stack la suma sera n + x donde n seran los elementos del inventario y x los del suelo
						btn.get_child(0).text = str(btn.get_child(0).text.to_int() + obj.get_child(0).text.to_int())
						btn.get_child(0).queue_redraw()
						obj.queue_free()
				return true
	return false
				
func add(obj:Node):
	if get_parent().clase == obj.item['clase'] or obj.item['clase'] == "cualquiera":
		for i in $GridContainer.get_children():
			var btn = i.get_child(0)
			if btn.icon == null:
				btn.icon = obj.image # cambiamos el icono del boton
				i.item = obj.item # añadimos las stats del arma, aunque por el momento solo añadimos el tipo de arma que es el ID
				btn.get_child(0).text = obj.get_child(0).text # Y si tiene más de un elemento se añade al label del inventario
				obj.queue_free()
				return true
		warning("Sin espacio en el inventario")
	else:
		warning("Debes pertenecer a la clase " + obj.item['clase'] + " para tomar esto")
func update_stats():
	for i in $GridContainer.get_children():
		for j in i.item["bonus"]:
			pass
