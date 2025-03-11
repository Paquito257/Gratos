extends AnimatedSprite2D

@export var flipped : bool = false
@export var enemy_name : String
@onready var stats = $Stats
@onready var life = $Life

@export var attacks : Array[Skill] = []
@export var enemy = true

func _ready():
	life.max_value = stats.vida
	life.value = stats.vida
	flip_h = flipped
	play("Idle")

func _process(delta):
	pass
			
#Actualiza la vida del enemigo
func update_stats():

	if life.value != stats.vida:
		life.value = stats.vida
		if life.value > 0:
			play("Hurt")
			
		else:
			play("Death")

func _on_animation_finished() -> void:
	print(animation)
	
	if animation == "Attack":
		play("Idle")
		
	elif animation == "Hurt":
		play("Idle")
		
	elif animation == "Death":
		get_parent().exp_total += stats.exp
	
func choose_random_skill():
	var actual_attack = attacks.pick_random()
	
	while stats.magia < actual_attack.Magic:
		actual_attack = attacks.pick_random()
		
	return actual_attack
	
