extends HBoxContainer

signal  election(old:Node,new:Node)
var active = false
# Instancias de los objetos a intercambiar cuando se tenga ya un objeto que es unico en el inventario
var oldM 
var newM
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Si el boton esta activo se obtiene los datos del objeto del inventario y son intercambiados por el nuevo
	if active:
		var old_id = oldM.get_parent().item
		var old_img = oldM.icon
		oldM.icon = newM.image
		oldM.get_parent().item = newM.item
		$old.icon = null
		$new.icon = null
		newM.image = old_img
		newM.get_child(1).texture = old_img
		newM.id_item = old_id
		newM.queue_redraw()
		visible = false
		active = false
		get_parent().get_node("bg").visible = false
		


func _on_election(old: Node, new: Node) -> void:
	oldM = old
	newM = new


# Si elige quedarse con el mismo objeto unicamente se esconde el nael de opciones
func _on_old_button_up() -> void:
	$old.icon = null
	$new.icon = null
	visible = false

# Si elige cambiar el objeto se activa el boton
func _on_new_button_up() -> void:
	active = true
