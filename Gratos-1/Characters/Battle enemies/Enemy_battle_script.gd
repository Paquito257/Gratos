extends CharacterBody2D

@export var flipped : bool = false
@export var enemy_name : String

@onready var stats = $Stats
@onready var animation = $animation
@onready var life = $Life
@export var attacks : Array[Skill] = []

func _ready():
	life.max_value = stats.vida
	life.value = stats.vida
	animation.flip_h = flipped
	animation.play()
	
	

func _process(delta):
	pass
	
func update_perc():
	pass
	
