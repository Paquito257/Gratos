extends AnimatedSprite2D

#Variables que se mostraran en el inspector del nodo correspondiente
#al personaje
@export_category("Player settings")
@export_enum("caballero","mago", "arquero","barbaro") var clase = "mago"
@export var nivel:int = 1
@export var attacks : Array[Resource] 
