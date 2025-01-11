extends Area2D

var item_ide: int = 1
var costo = 5
var efecto = 20
var ref: Node
var id_item
@export var image : Texture2D
var path
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = image
	path = $"Sprite2D".texture.resource_path
	if(path == "res://inventory/items/espada2.png"):
		id_item = 0
	elif (path == "res://inventory/items/veneno.png"):
		id_item = 2
	elif (path == "res://inventory/items/arco.png" or path == "res://inventory/items/hacha.png"):
		id_item = 3
	else:
		id_item = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

# Logica para posicionar el item en el inventario
func _on_body_entered(body: Node2D) -> void: 
	if body != null: # aqui hay que añadir un and y verificar si verdaderamente es un player
		var inventory = body.get_node("inventario/GridContainer") # Obtenemos el nodo inventario del cuerpo que esta iteractuando
		if inventory != null: 
			for i in inventory.get_children(): # Listamos todos los slots para empezar la busqueda de un espacio vacio
				var button = i.get_child(0) # obtenemos el boton del slot en cuestion
				 # Si el slot esta vacio se buscara si no hay otro elemento del mismo tipo para hacer un stack 
				for j in inventory.get_children():
					if j.item["id"] == id_item:
						var button2 = j.get_child(0)
						if j.item['id'] != 3:
							if button2.get_child(0).text == "": 
								if $Label.text.to_int() == 0: # Si se encontro un elemento igual y este no tiene mas de dos items en el inventario ni en el mapa se suma 1 + 2 = 2
									button2.get_child(0).text = str(1 + 1) # Aqui simplemente se actualiza el label que tiene el boton
									button2.get_child(0).queue_redraw()
									queue_free()
								else: # Si el elemento a recoger tiene más de uno la suma de los item sera 1 + n, donde n es el número de items que hay en el stack del suelo
									button2.get_child(0).text = str(1 + $Label.text.to_int())
									button2.get_child(0).queue_redraw()
									queue_free() # eliminamos el item del suelo
							else: 
								if $Label.text.to_int() == 0: # Como el objeto encontrado en el invetario tiene n elementos se suma n + 1, ya que el del suelo solo tiene 1
									button2.get_child(0).text = str(button2.get_child(0).text.to_int() + 1)
									button2.get_child(0).queue_redraw()
									queue_free()
								else: # Si el objeto del suelo es un stack la suma sera n + x donde n seran los elementos del inventario y x los del suelo
									button2.get_child(0).text = str(button2.get_child(0).text.to_int() + $Label.text.to_int())
									button2.get_child(0).queue_redraw()
									queue_free()
							return
							
				if button.icon == null: # Como no se encontro ningún elemento que actualizar se añade al inventario
					button.icon = image # cambiamos el icono del boton
					i.item = {"id": id_item} # añadimos las stats del arma, aunque por el momento solo añadimos el tipo de arma que es el ID
					button.get_child(0).text = $Label.text # Y si tiene más de un elemento se añade al label del inventario
					queue_free()
					return
				elif i.item["id"] != null:
					if i.item['id'] == 3: # Si el slot esta ocupado y es un objeto especial directamente envia un warning
						if id_item == i.item['id']:
							var container = body.get_node("inventario/Election")
							container.visible = true # se hace visible el panel para la elección
							body.get_node("inventario/bg").visible = true
							
							# se obtienen los nodos que se mostraran para que el usuario elija
							var old = body.get_node("inventario/Election/old")
							var new = body.get_node("inventario/Election/new")
							old.icon = button.icon
							new.icon = image
							# Se envian al script del panel para realizar el cambio
							container.emit_signal("election",button,$".")
							body.get_node("inventario/time2").start() # se inicia un contador de 2 segundos para esperar que el usuario decido sino se oculta todo
							return
			if not body.get_node("inventario/Election").visible:
				body.get_node("inventario/bg").visible = true
				body.get_node("inventario/Warning").text = "Sin espacio en el inventario" # Ya que no se cumplio ninguna de las condiciones anteriores se envia otro warning advirtiendo que el inventario esta lleno
				body.get_node("inventario/Warning").queue_redraw()
				body.get_node("inventario/time").start()
							
					
					
		
