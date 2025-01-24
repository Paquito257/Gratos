extends CharacterBody2D

@onready var animation = $Orc_animated
@onready var life = $Life

func _ready():
	animation.flip_h = true
	animation.play()
	life.max_value = $Stats.vida
	life.value = $Stats.vida
	

func _process(delta):
	pass
