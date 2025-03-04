@tool
extends CanvasLayer
@export_category("Animation settings")
@onready var animation_player = $"bg/AnimationPlayer"
var tipo_de_animacion: String:
	set(value):
		tipo_de_animacion = value
		notify_property_list_changed()
func _get_property_list() -> Array:	
	var properties: Array = []
	# Propiedad: clase de ítem
	properties.append({
		"name": "tipo_de_animacion",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Fade out,Zoom out,Fade in",
		"usage": PROPERTY_USAGE_DEFAULT,
 		})
	return properties

signal play
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play() -> void:
	$".".visible = true
	
	match tipo_de_animacion:
		"Fade out":
			animation_player.play("fade")
		"Zoom out":
			animation_player.play("zoom out")
		"Fade in":
			animation_player.play("Fade in")


func _on_animation_player_animation_finished(anim_name: StringName):
	$hide.start()

func _physics_process(delta: float) -> void:
	match tipo_de_animacion:
		"Fade out":
			_on_animation_player_animation_finished("fade")
		" Zoom out":
			_on_animation_player_animation_finished("zoom out")
		" Fade in":
			_on_animation_player_animation_finished("Fade in")
			
			


func _on_hide_timeout() -> void:
	$".".visible = false
