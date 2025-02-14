@tool
extends Node2D
class_name NPC_stats

var Stats: Array[int]
var vida : int
var magia : int
var velocidad : int
var ataque : int
var defensa : int
var exp : int

func _get_property_list() -> Array:
	var properties: Array = []
	
	properties.append({
		"name" : "Stats",
		"type" : TYPE_NIL,
		"usage" : PROPERTY_USAGE_CATEGORY,
		"hint_string" : "npc",
	})
	properties.append({
		"name" : "vida",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "magia",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "velocidad",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "defensa",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "ataque",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name" : "exp",
		"type" : TYPE_INT,
		"usage" : PROPERTY_USAGE_DEFAULT,
	})
	return properties
