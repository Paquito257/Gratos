@tool
extends Area2D
var ref: Node
var id_item

@export_category("Item settings")
# Propiedades principales
@export var image: Texture2D
var clase_de_item: String:
	set(value):
		clase_de_item = value
		notify_property_list_changed()
var nivel_del_item: String:
	set(value):
		nivel_del_item = value
		notify_property_list_changed()
var tipo: int:
	set(value):
		tipo = value
		notify_property_list_changed()
var tipo_de_item_keys: Array = tipo_de_item_clases.keys()
var tipo_de_item_list: String = ",".join(tipo_de_item_keys)
enum tipo_de_item_clases{
	equipable = 1 << 0,
	unico = 1 << 1,
	consumible = 1 << 2,
}
var tipo_de_consumible:String
var valor:int
var bonus = {"magia":null, "ataque":null,"defensa":null, "vida":null, "velocidad": null}
func _get_property_list() -> Array:	
	var properties: Array = []
	# Propiedad: clase de ítem
	properties.append({
		"name": "clase_de_item",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "arquero,barbaro,caballero,mago,cualquiera",
		"usage": PROPERTY_USAGE_DEFAULT,
	})
		
	# Propiedad: tipo de item
	properties.append({
		"name": "tipo",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": tipo_de_item_list,
	})
	if tipo == 2:
		properties.append({
			"name": "tipo_de_consumible",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "ataque,defensa,velocidad,vida,magia",
			"usage": PROPERTY_USAGE_DEFAULT,
		})
		properties.append({
			"name": "valor",
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_DEFAULT,
		})
	else: 
		# Propiedad: nivel del ítem
		properties.append({
			"name": "nivel_del_item",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "comun,raro,epico,legendario",
			"usage": PROPERTY_USAGE_DEFAULT,
		})
	return properties
 
@onready var nodo = $"."
var item = {}
var path
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item = {
	"clase": clase_de_item, # Es la clase la cual puede iteracturar con este objeto
	"nivel": nivel_del_item, # El nivel de poder del objeto 
	"tipo": tipo, # Determina como se guardara el item en el inventario
	"bonus": bonus,
	}
	$Sprite2D.texture = image
	match item['clase']:
		"mago":
			match item['tipo']:
				0: # Equipables
					pass
				1: # Unicos
					match item["nivel"]:
						"comun":
							item["bonus"]["magia"] = 20
						"raro":
							item["bonus"]["defensa"] = 25
							item["bonus"]["magia"] = 15
						"epico":
							item["bonus"]["magia"] = 10
							item["bonus"]["defensa"] = 10
							item["bonus"]["velocidad"] = 10
						"legendario":
							item["bonus"]["magia"] = 50
							item["bonus"]["vida"] = 20
				2: # Consumibles
					item['consumible'] = tipo_de_consumible
					item['bonus'][tipo_de_consumible] = valor
		"arquero":
			match item['tipo']:
				0: # Equipables
					pass
				1: # Unicos
					match item["nivel"]:
						"comun":
							item["bonus"]["ataque"] = 20
						"raro":
							item["bonus"]["velocidad"] = 10
							item["bonus"]["magia"] = 15
						"epico":
							item["bonus"]["magia"] = 30
							item["bonus"]["ataque"] = -15
							item["bonus"]["velocidad"] = 10
						"legendario":
							item["bonus"]["ataque"] = 25
							item["bonus"]["velocidad"] = 15
							item["bonus"]["vida"] = 20
				2: # Consumibles
					item['consumible'] = tipo_de_consumible
					item['bonus'][tipo_de_consumible] = valor
				
		"caballero":
			match item['tipo']:
				0: # Equipables
					pass
				1: # Unico
					match item["nivel"]:
						"comun":
							item["bonus"]["ataque"] = 10
							item["bonus"]["defensa"] = 10
						"raro":
							item["bonus"]["ataque"] = 25
							item["bonus"]["defensa"] = 15
							item["bonus"]["velocidad"] = -5
						"epico":
							item["bonus"]["ataque"] = 15
							item["bonus"]["velocidad"] = 15
						"legendario":
							item["bonus"]["ataque"] = 15
							item["bonus"]["velocidad"] = 15
							item["bonus"]["vida"] = 20
				2: # Consumibles
					item['consumible'] = tipo_de_consumible
					item['bonus'][tipo_de_consumible] = valor
		"barbaro":
			match item['tipo']:
				0: # Equipables
					pass
				1: # Unico
					match item["nivel"]:
						"comun":
							item["bonus"]["ataque"] = 10
							item["bonus"]["defensa"] = 10
						"raro":
							item["bonus"]["ataque"] = 25
						"epico":
							item["bonus"]["ataque"] = 50
							item["bonus"]["vida"] = -50
						"legendario":
							item["bonus"]["ataque"] = -15
							item["bonus"]["defensa"] = 20
							item["bonus"]["vida"] = 30
				2: # Consumibles
					item['consumible'] = tipo_de_consumible
					item['bonus'][tipo_de_consumible] = valor
		"cualquiera":
			match item['tipo']:
				0: # Equipables
					pass
				1: # Unico
					pass
				2: # Consumibles
					item['consumible'] = tipo_de_consumible
					item['bonus'][tipo_de_consumible] = valor


			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

# Logica para posicionar el item en el inventario
func _on_body_entered(body: Node2D) -> void: 
	var inventario = body.get_node("inventario")
	if inventario.find_similar_object($"."):
		pass
	else:
		inventario.add($".")
					
		
