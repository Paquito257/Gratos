extends CharacterBody2D

@onready var life = $Life
@export var fliped : bool = false
@export var animation : AnimatedSprite2D

func _ready():
	life.max_value = $Stats.vida
	life.value = $Stats.vida
	animation.flip_h = fliped
	animation.play()
	
	

func _process(delta):
	pass
