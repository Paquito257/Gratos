extends AnimatedSprite2D

@export var flipped : bool = false
@export var enemy_name : String
@onready var stats = $Stats
@onready var life = $Life
		
@export var attacks : Array[Skill] = []

func _ready():
	life.max_value = stats.vida
	life.value = stats.vida
	flip_h = flipped
	play("Idle")

func _process(delta):
	pass
		
func update_stats():
	if life.value > 0:
		life.value = stats.vida
		play("Hurt")
		
		
	elif life.value <= 0:
		play("Death")
