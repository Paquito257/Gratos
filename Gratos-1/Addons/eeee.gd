@tool
extends Area2D

@export var parent : Node2D
var area : CollisionShape2D
var tool : NPC

func _process(delta):
	if Engine.is_editor_hint():
		if is_instance_valid(parent):

			tool = parent.resource
			check()
			
func check():
	if get_child_count() < 1:
		area = CollisionShape2D.new()
		add_child(area)
	var shape : Shape2D
	shape = tool.Event
	area.shape = shape

