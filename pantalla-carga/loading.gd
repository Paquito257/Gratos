extends Node2D


func _ready():
	$TextureProgressBar.tint_under = Color(1,1,1,0.5)


func _on_timer_timeout():
	$ProgressBar.value += 25
	$TextureProgressBar.value += 25


func _on_animation_player_animation_finished(anim_name: StringName):
	get_tree().change_scene_to_file("res://menu.tscn")
