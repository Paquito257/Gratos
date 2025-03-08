extends Node

#Función que realiza el cálculo del daño del ataque
#(Debe recibir TODO: terminar el comentario xd)
func dmg_calculator( from, to, skill):
	if skill.Magia == 0:
		to.stats.Vida -= int((skill.Ataque + from.stats.Ataque*(from.nivel/10)) - to.stats.Defensa)
	
	else:
		to.stats.Vida -= int(skill.Ataque + from.nivel/2)
