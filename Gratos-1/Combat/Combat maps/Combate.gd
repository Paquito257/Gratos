extends Node2D

@onready var option = $CanvasLayer
@onready var scenario = $"."
var entities = []

func turn():
	pass
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turn()
