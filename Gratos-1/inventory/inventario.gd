extends CanvasLayer

var inventario = []

# Called when the node enters the scene tree for the first time.
@export var item_scene : PackedScene
func _ready() -> void:
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
# Encuentra un objeto similar y hace un stack si es un objeto que no es unico
func find_similar_object(obj:Node):
	for i in $GridContainer.get_children():
		var btn = i.get_child(0)
		if btn.icon == null: continue
		if obj.image.get_path() == btn.icon.get_path() and obj.item.nameObj == btn.item.nameObj:
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
					if obj.get_child(0).text.to_int() == 0: # Si se encontro un elemento igual y este no tiene mas de dos items en el inventario ni en el mapa se suma 1 + 1 = 2
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
	
# Añade el objeto a un slot vacio			
func add(obj:Node):
	if get_parent().character.clase == obj.item['clase'] or obj.item['clase'] == "cualquiera":
		for i in $GridContainer.get_children():
			var btn = i.get_child(0)
			if btn.icon == null:
				btn.icon = obj.image # cambiamos el icono del boton
				i.item = obj.item # añadimos las stats del arma, aunque por el momento solo añadimos el tipo de arma que es el ID
				btn.get_child(0).text = obj.get_child(0).text # Y si tiene más de un elemento se añade al label del inventario
				obj.queue_free()
				update_stats(i.item['bonus'])
				return true
		warning("Sin espacio en el inventario")
	else:
		warning("Debes pertenecer a la clase " + obj.item['clase'] + " para tomar esto")

# Actualiza las stats cuando se recoge un objeto
func update_stats(bonus:Dictionary):
	var stats = get_parent().get_node("./Stats")
	if bonus.ataque != null:
		stats.add_to(bonus.ataque,"ataque")
		
	if bonus.velocidad != null:
		stats.add_to(bonus.velocidad,"velocidad")
		
	if bonus.defensa != null:
		stats.add_to(bonus.defensa,"defensa")
		
	if bonus.vida != null:
		var vida = stats.check_stats("vida")
		stats.set_stats(bonus.ataque + vida,"vida")
		
	if bonus.magia != null:
		var magia = stats.check_stats("magia")
		stats.set_stats(bonus.ataque + magia,"magia")

#Devuelve todos los elementos del invetario
func get_all_items():
	for i in $GridContainer.get_children():
		inventario.append(i.item)
	return inventario
	
# BUsca un item por el nombre	
func get_item_by_name(nameObj):
	var aux = get_all_items()
	for i in aux:
		if i.name.to_lower() == nameObj.to_lower():
			return i
			
# Elimina un objeto del inventario o resta 1 si hay más
func delete(nameObj):
	for i in $GridContainer.get_children():
		if i.item.name.to_lower() == nameObj.to_lower():
			if i.get_node("./Button/number").text.to_int() <= 0:
				i.icon = null
				i.item = {
						"nameObj":nameObj.to_lower(),
						"clase": null, # Es la clase la cual puede iteracturar con este objeto
						"nivel": null, # El nivel de poder del objeto 
						"tipo": null, # Determina como se guardara el item en el inventario
						"bonus": null,
						"icon": null,
					}
				return
			else: 
				i.get_node("./Button/number").text = str(i.get_node("./Button/number").text.to_int() - 1)
			
