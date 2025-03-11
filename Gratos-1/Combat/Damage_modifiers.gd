extends Node

#Variable para confirmar que solo se baje la magia una vez si el
#ataque es a todos
var global_dropped = false

#Función que realiza el cálculo del daño del ataque
#(Debe recibir TODO: terminar el comentario xd)
func dmg_calculator( from, to, skill, level, global = false):
	
	if hit_rate(skill):
		print(skill.Skill_name)
		print(skill.Magic)
		if skill.Magic == 0:
			if int((skill.Damage + from.ataque*(level/10)) - to.defensa) <= 0:
				to.vida -= 1
			else:
				to.vida -= int((skill.Damage + from.ataque*(level/10)) - to.defensa)
		
		else:
			to.vida -= int(skill.Damage + level/2)
			
			if !global:
				from.magia -= skill.Magic
			
			elif !global_dropped:
				from.magia -= skill.Magic
				global_dropped = true
	
#Determina si la skill acierta o no
func hit_rate(skill):
	var accuracy = skill.Success #Como variable, en el caso de que se pueda aumentar la evasion (TODO)
	randomize()
	var RNG = randf()
	
	if accuracy >= RNG:
		return true
	
	else:
		print("Fail")

	
