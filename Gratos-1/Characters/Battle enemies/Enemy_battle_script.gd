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
			Music.hit.play()
			
		else:
			play("Death")
			Music.hit.play()

func _on_animation_finished() -> void:
	
	if animation == "Attack":
		play("Idle")
		await get_tree().create_timer(1).timeout
		get_parent().turn_actual = true
		
	elif animation == "Hurt":
		play("Idle")
		
	elif animation == "Death":
		pass
	
func choose_random_skill():
	var actual_attack = attacks.pick_random()
	
	while stats.magia < actual_attack.Magic:
		actual_attack = attacks.pick_random()
		
	return actual_attack
	
