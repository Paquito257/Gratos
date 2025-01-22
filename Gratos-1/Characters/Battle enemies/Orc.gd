extends CharacterBody2D

@onready var animation = $Orc_animated

var stats = {
	
}

func _ready():
	animation.flip_h = true
	animation.play()
	

func _process(delta):
	pass
