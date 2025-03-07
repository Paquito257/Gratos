extends CharacterBody2D

@export var flipped : bool = false
@export var enemy_name : String

@onready var animation = $animation
@onready var life = $Life



func _ready():
	life.max_value = $Stats.vida
	life.value = $Stats.vida
	animation.flip_h = flipped
	animation.play()
	
	

func _process(delta):
	pass
	
func update_perc():
	pass
	
