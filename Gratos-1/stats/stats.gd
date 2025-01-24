extends CanvasLayer
var clase: String
# Devuelve una de las stats del personaje para verificar su valor
func check_stats(stat:String = ""):
	match stat:
		"":
			var all_stats = {
							"vida":$vida/ProgressBar.value,
							"magia":$Magia/ProgressBar.value,
							"velocidad":$menu/Velocidad/Cantidad.text.to_int(),
							"defensa": $menu/Defensa/Cantidad.text.to_int(),
							"ataque": $menu/Ataque/Cantidad.text.to_int()
							}
			return all_stats
		"vida": return $vida/ProgressBar.value
		"magia": return $Magia/ProgressBar.value
		"velocidad": return $menu/Velocidad/Cantidad.text.to_int()
		"defensa": return $menu/Defensa/Cantidad.text.to_int()
		"ataque": return $menu/Ataque/Cantidad.text.to_int()
		_:
			var all_stats = {
							"vida":$vida/ProgressBar.value,
							"magia":$Magia/ProgressBar.value,
							"velocidad":$menu/Velocidad/Cantidad.text.to_int(),
							"defensa": $menu/Defensa/Cantidad.text.to_int(),
							"ataque": $menu/Ataque/Cantidad.text.to_int()
							}
			return all_stats 
			

# Modifica el valor de las stats según lo especificado
func add_to(value,stat:String = ""):
	if value != null:
		match stat:
			"vida": 
				$vida/ProgressBar.value = $vida/ProgressBar.value + value
				$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
				$"vida/ProgressBar".queue_redraw()
			"magia": 
				$Magia/ProgressBar.value = $Magia/ProgressBar.value + value
				$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
				$"Magia/ProgressBar".queue_redraw()
			"velocidad":  
				if $menu/Velocidad/Cantidad.text.to_int() < 100 and value < 100:
					$menu/Velocidad/Cantidad.text = str($menu/Velocidad/Cantidad.text.to_int() + value)
					$"menu/Velocidad/Cantidad".queue_redraw()
			"defensa":
				if $menu/Defensa/Cantidad.text.to_int() < 100 and value < 100:
					$menu/Defensa/Cantidad.text = str($menu/Defensa/Cantidad.text.to_int() + value)
					$"menu/Defensa/Cantidad".queue_redraw()
			"ataque": 
				if $menu/Ataque/Cantidad.text.to_int() < 100 and value < 100:
					$menu/Ataque/Cantidad.text = str($menu/Ataque/Cantidad.text.to_int() + value)
					$"menu/Ataque/Cantidad".queue_redraw()
			
# Establece el valor de la stats eliminando el anterior
func set_stats(value,stat:String = ""):
	if value != null:
		match stat:
			"":
				$vida/ProgressBar.value = value
				$vida/ProgressBar.max_value = $vida/ProgressBar.value 
				$vida/ProgressBar/Cantidad.text = str(value)
				$"vida/ProgressBar".queue_redraw()
				
				$Magia/ProgressBar.value = value
				$Magia/ProgressBar.max_value = $Magia/ProgressBar.value 
				$Magia/ProgressBar/Cantidad.text = str(value)
				$"Magia/ProgressBar".queue_redraw()
				
				$menu/Velocidad/Cantidad.text = str(value)
				$"menu/Velocidad/Cantidad".queue_redraw()
				
				$menu/Defensa/Cantidad.text = str(value)
				$"menu/Defensa/Cantidad".queue_redraw()
				
				$menu/Ataque/Cantidad.text = str(value)
				$"menu/Ataque/Cantidad".queue_redraw()
				
			"vida":
				$vida/ProgressBar.value = value
				$vida/ProgressBar/Cantidad.text = str(value)
				$"vida/ProgressBar".queue_redraw()
			"magia": 
				$Magia/ProgressBar.value = value
				$Magia/ProgressBar/Cantidad.text = str(value)
				$"Magia/ProgressBar".queue_redraw()
			"velocidad": 
				$menu/Velocidad/Cantidad.text = str(value)
				$"menu/Velocidad/Cantidad".queue_redraw()
			"defensa": 
				$menu/Defensa/Cantidad.text = str(value)
				$"menu/Defensa/Cantidad".queue_redraw()
			"ataque": 
				$menu/Ataque/Cantidad.text = str(value)
				$"menu/Ataque/Cantidad".queue_redraw()
		
# Establece las stats según la clase del personaje
func level_up(clase:String = "",nivel:int = 0):
	if nivel == 0 : nivel = 1
	match clase:
		"mago":
			$vida/ProgressBar.value = 28 + 4 * nivel
			$vida/ProgressBar.max_value = $vida/ProgressBar.value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.value = 15 + 4 * nivel
			$Magia/ProgressBar.max_value = $Magia/ProgressBar.value 
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
			
		"arquero":
			$vida/ProgressBar.value = 25 + 2 * nivel
			$vida/ProgressBar.max_value = $vida/ProgressBar.value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.value = 10 + 3 * nivel
			$Magia/ProgressBar.max_value = $Magia/ProgressBar.value 
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(3 + 5 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 4 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
		
		"caballero": 
			$vida/ProgressBar.value = 32 + 5 * nivel
			$vida/ProgressBar.max_value = $vida/ProgressBar.value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.value = 10 + 2 * nivel
			$Magia/ProgressBar.max_value = $Magia/ProgressBar.value 
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 2 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
		
		"barbaro": 
			$vida/ProgressBar.value = 40 + 8 * nivel
			$vida/ProgressBar.max_value = $vida/ProgressBar.value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.value = 0
			$Magia/ProgressBar.max_value = $Magia/ProgressBar.value 
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 2 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 4 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clase = get_parent().clase
	if clase == "barbaro": $Magia.visible = false
	else: $Magia.visible = true
	level_up(clase,get_parent().nivel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_open_pressed() -> void:
	$menu.visible = true
	$open.visible = false



func _on_cerrar_pressed() -> void:
	$menu.visible = false
	$open.visible = true
