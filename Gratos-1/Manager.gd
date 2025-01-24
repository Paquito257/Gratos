@tool
extends Resource
class_name NPC

var Name: String 
var Dialogue: Array[String]

var Friendly : bool:
	set(value):
		Friendly = value
		notify_property_list_changed()
	

func _get_property_list() -> Array:
	var properties: Array = []
	
	properties.append({
		"name" : "NPC Properties",
		"type" : TYPE_NIL,
		"usage" : PROPERTY_USAGE_CATEGORY,
		"hint_string" : "npc",
	})
	properties.append({
		"name" : "Name",
		"type" : TYPE_STRING,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "Friendly",
		"type" : TYPE_BOOL,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	if Friendly:
		properties.append({
			"name" : "Dialogue",
			"type" : TYPE_ARRAY,
			"usage" : PROPERTY_USAGE_DEFAULT,
			"hint" : PROPERTY_HINT_TYPE_STRING,
			"hint_string" : "%d:" % [TYPE_STRING]

		})
	return properties
