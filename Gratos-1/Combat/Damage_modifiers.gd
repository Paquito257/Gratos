extends Node

#Función que realiza el cálculo del daño del ataque
#(Debe recibir TODO: terminar el comentario xd)
func dmg_calculator( from, to, skill, level):
	if skill.Magic == 0:
		if int((skill.Damage + from.ataque*(level/10)) - to.defensa) == 0:
			to.vida -= 1
		else:
			to.vida -= int((skill.Damage + from.ataque*(level/10)) - to.defensa)
	
	else:
		to.vida -= int(skill.Damage + level/2)
		from.magia -= skill.Magic
