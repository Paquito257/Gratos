extends CanvasLayer
var clase: String

@onready var all_stats = {
		"vida":$vida/ProgressBar.value,
		"max_vida":$vida/ProgressBar.max_value,
		"magia":$Magia/ProgressBar.value,
		"max_magia":$Magia/ProgressBar.max_value,
		"velocidad":$menu/Velocidad/Cantidad.text.to_int(),
		"defensa": $menu/Defensa/Cantidad.text.to_int(),
		"ataque": $menu/Ataque/Cantidad.text.to_int(),
		"exp": $Exp/ProgressBar.value
		}
# Devuelve una de las stats del personaje para verificar su valor
func check_stats(stat:String = ""):
	match stat:
		"": return all_stats
		"vida": return $vida/ProgressBar.value
		"magia": return $Magia/ProgressBar.value
		"velocidad": return $menu/Velocidad/Cantidad.text.to_int()
		"defensa": return $menu/Defensa/Cantidad.text.to_int()
		"ataque": return $menu/Ataque/Cantidad.text.to_int()
		_:
			return all_stats 
			

# Modifica el valor de las stats según lo especificado
func add_to(value,stat:String = ""):
	if value != null:
		match stat:
			"vida": 
				if  value + $vida/ProgressBar.value < $vida/ProgressBar.max_value:
					$vida/ProgressBar.value = $vida/ProgressBar.value + value
					$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
					$"vida/ProgressBar".queue_redraw()
				else:
					var diferencia = $vida/ProgressBar.value + value - $vida/ProgressBar.max_value
					$vida/ProgressBar.value = $vida/ProgressBar.value + value - diferencia
					$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
					$"vida/ProgressBar".queue_redraw()
			"magia": 
				if  value + $Magia/ProgressBar.value < $Magia/ProgressBar.max_value:
					$Magia/ProgressBar.value = $Magia/ProgressBar.value + value
					$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
					$"Magia/ProgressBar".queue_redraw()
				else:
					var diferencia = $Magia/ProgressBar.value + value - $Magia/ProgressBar.max_value
					$Magia/ProgressBar.value = $Magia/ProgressBar.value + value - diferencia
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
			$vida/ProgressBar.max_value = 28 + 4 * nivel 
			$vida/ProgressBar.value = $vida/ProgressBar.max_value
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.max_value = 15 + 4 * nivel
			$Magia/ProgressBar.value = $Magia/ProgressBar.max_value  
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
			
		"arquero":
			$vida/ProgressBar.max_value = 25 + 2 * nivel 
			$vida/ProgressBar.value = $vida/ProgressBar.max_value
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.max_value = 10 + 3 * nivel
			$Magia/ProgressBar.value = $Magia/ProgressBar.max_value 
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(3 + 5 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 4 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
		
		"caballero": 
			$vida/ProgressBar.max_value = 32 + 5 * nivel 
			$vida/ProgressBar.value = $vida/ProgressBar.max_value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.max_value = 10 + 2 * nivel
			$Magia/ProgressBar.value = $Magia/ProgressBar.max_value
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 2 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 3 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()
		
		"barbaro": 
			$vida/ProgressBar.max_value = 40 + 8 * nivel 
			$vida/ProgressBar.value = $vida/ProgressBar.max_value 
			$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
			$"vida/ProgressBar".queue_redraw()
			
			$Magia/ProgressBar.max_value = 0
			$Magia/ProgressBar.value = $Magia/ProgressBar.max_value
			$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
			$"Magia/ProgressBar".queue_redraw()
			
			$menu/Velocidad/Cantidad.text = str(2 + 1 * nivel)
			$"menu/Velocidad/Cantidad".queue_redraw()
			
			$menu/Defensa/Cantidad.text = str(2 + 2 * nivel)
			$"menu/Defensa/Cantidad".queue_redraw()
			
			$menu/Ataque/Cantidad.text = str(2 + 4 * nivel)
			$"menu/Ataque/Cantidad".queue_redraw()

# Establece las stats a través de un diccionario
func set_all_stats(stats):
	if stats.ataque != null:
		add_to(stats.ataque,"ataque")
		
	if stats.velocidad != null:
		add_to(stats.velocidad,"velocidad")
		
	if stats.defensa != null:
		add_to(stats.defensa,"defensa")
		
	if stats.vida != null:
		$vida/ProgressBar.value = stats.vida
		$vida/ProgressBar.max_value = stats.max_vida 
		$vida/ProgressBar/Cantidad.text = str($vida/ProgressBar.value)
		$"vida/ProgressBar".queue_redraw()
		
	if stats.magia != null:
		$Magia/ProgressBar.value = stats.magia
		$Magia/ProgressBar.max_value = stats.max_magia 
		$Magia/ProgressBar/Cantidad.text = str($Magia/ProgressBar.value)
		$"Magia/ProgressBar".queue_redraw()
		
	if stats.exp != null:
		$Exp/ProgressBar.value = stats.exp
		$Exp/ProgressBar.max_value = GameControl.level_milestones
		$Exp/ProgressBar/Cantidad.text = str($Exp/ProgressBar.value)
		$Exp/ProgressBar.queue_redraw()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Exp/ProgressBar.max_value = GameControl.level_milestones
	$Exp/ProgressBar/Cantidad.text = str($Exp/ProgressBar.value)
	$Exp/Label.text = str("Lvl %s" % PlayerHandle.players[multiplayer.get_unique_id()].level)
	clase = get_parent().character.clase
	if clase == "barbaro": $Magia.visible = false
	else: $Magia.visible = true
	if PlayerHandle.players[multiplayer.get_unique_id()].stats == null:
		level_up(clase,PlayerHandle.players[multiplayer.get_unique_id()].level)
	else:
		set_all_stats(PlayerHandle.players[multiplayer.get_unique_id()].stats)
		if PlayerHandle.players[multiplayer.get_unique_id()].level >= GameControl.new_level:
			level_up(clase,PlayerHandle.players[multiplayer.get_unique_id()].level)
			GameControl.new_level =  PlayerHandle.players[multiplayer.get_unique_id()].level + 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	all_stats = {
			"vida":$vida/ProgressBar.value,
			"max_vida":$vida/ProgressBar.max_value,
			"magia":$Magia/ProgressBar.value,
			"max_magia":$Magia/ProgressBar.max_value,
			"velocidad":$menu/Velocidad/Cantidad.text.to_int(),
			"defensa": $menu/Defensa/Cantidad.text.to_int(),
			"ataque": $menu/Ataque/Cantidad.text.to_int(),
			"exp": $Exp/ProgressBar.value
			}
			
	PlayerHandle.players[multiplayer.get_unique_id()].stats = all_stats


func _on_open_pressed() -> void:
	$menu.visible = true
	$open.visible = false



func _on_cerrar_pressed() -> void:
	$menu.visible = false
	$open.visible = true
