extends Sprite2D

@export var texto:String = "":
	set(value):
		texto = value
		$Timer.start()

var index = 0;

func _on_timer_timeout() -> void:
	if index >= texto.length():
		$Timer.stop()
	else:
		$Label.text = $Label.text + texto[index]
		index += 1

#func _on_timeresconde_timeout():
	#visible = false
