extends Control

# Enumeración de estados de misiones
enum QuestStatus {ACTIVE, COMPLETED, FAILED}

# Estructura de datos para misiones
var quests = []

# Nodos de UI
@onready var quest_list = $ScrollContainer/QuestsList

func _ready():
	# Ejemplo de misiones iniciales (deberías cargarlas desde tu sistema de guardado)
	add_quest({
		"id": 1,
		"title": "Encuentra la espada legendaria",
		"description": "Busca la espada en las ruinas del norte",
		"status": QuestStatus.ACTIVE,
		"objectives": [
			{"description": "Llegar a las ruinas", "completed": false},
			{"description": "Derrotar al guardián", "completed": false},
			{"description": "Recuperar la espada", "completed": false}
		],
		"rewards": "1000 oro, Espada del Héroe"
	})
	
	add_quest({
		"id": 2,
		"title": "Ayuda al herrero",
		"description": "Consigue 5 lingotes de hierro",
		"status": QuestStatus.COMPLETED,
		"objectives": [
			{"description": "Recolectar lingotes (5/5)", "completed": true}
		],
		"rewards": "Martillo mejorado"
	})
	
	update_quest_display()

# Añade una nueva misión al registro
func add_quest(quest_data):
	quests.append(quest_data)

# Actualiza la misión en el registro
func update_quest(quest_id, new_data):
	for quest in quests:
		if quest["id"] == quest_id:
			quest.merge(new_data)
			update_quest_display()
			return

# Actualiza la visualización de misiones
func update_quest_display():
	# Limpiar lista anterior
	for child in quest_list.get_children():
		child.queue_free()
	
	# Separadores de sección
	var active_header = Label.new()
	active_header.text = "--- MISIONES ACTIVAS ---"
	active_header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quest_list.add_child(active_header)
	
	# Mostrar misiones activas
	for quest in quests:
		if quest["status"] == QuestStatus.ACTIVE:
			add_quest_entry(quest)
	
	# Separador de completadas
	var completed_header = Label.new()
	completed_header.text = "--- MISIONES COMPLETADAS ---"
	completed_header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quest_list.add_child(completed_header)
	
	# Mostrar misiones completadas
	for quest in quests:
		if quest["status"] == QuestStatus.COMPLETED:
			add_quest_entry(quest)

# Crea una entrada visual para cada misión
func add_quest_entry(quest):
	var container = VBoxContainer.new()
	container.set("theme_override_constants/separation", 10)
	
	var title = Label.new()
	title.text = quest["title"]
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	title.set("theme_override_fonts/font", load("res://fonts/bold_font.tres"))  # Usa tu propia fuente
	
	var desc = Label.new()
	desc.text = quest["description"]
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	
	var objectives = VBoxContainer.new()
	for objective in quest["objectives"]:
		var obj_label = Label.new()
		var status = "[✓]" if objective["completed"] else "[✗]"
		obj_label.text = "%s %s" % [status, objective["description"]]
		objectives.add_child(obj_label)
	
	var rewards = Label.new()
	rewards.text = "Recompensa: %s" % quest["rewards"]
	
	# Cambiar color basado en estado
	if quest["status"] == QuestStatus.COMPLETED:
		title.modulate = Color.GREEN
	elif quest["status"] == QuestStatus.FAILED:
		title.modulate = Color.RED
	
	container.add_child(title)
	container.add_child(desc)
	container.add_child(objectives)
	container.add_child(rewards)
	
	# Añadir separador
	var separator = HSeparator.new()
	quest_list.add_child(container)
	quest_list.add_child(separator)

# Función para llamar cuando se completa una misión
func complete_quest(quest_id):
	for quest in quests:
		if quest["id"] == quest_id:
			quest["status"] = QuestStatus.COMPLETED
			for objective in quest["objectives"]:
				objective["completed"] = true
			update_quest_display()
			return
