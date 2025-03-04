extends Control


func _ready():
	$Transtion._on_play()
	$"AnimationPlayer".play("RESET")
	print(get_parent().get_node("/root/control"))
##al finalizar la animación de carga, instancia la pantalla de seleccion de personaje
func _on_animation_player_animation_finished(anim_name: StringName="RESET"):
	var listo = load("res://selec_personaje.tscn").instantiate()
	get_tree().root.add_child(listo)
	$WorldEnvironment.environment.glow_enabled = false
	$".".visible = false
