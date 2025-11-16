extends Node

class_name NPCOrder
	
enum order_potion_type { DarkVision, Thorns, FeignDeath,  Slow, Dangersense, Sleep, Truesight, Intelligence, Haste, Strength, Gills, Stealth, Healing, Focus, Wings, Growth, Stoneskin, Agility}
enum order_viscosity_type { VeryThin, Thin, Normal, Thick, VeryThick}
var order_type
var order_length: float 
var order_viscosity

func randomize_order():
	order_type = order_potion_type.keys()[randi() % order_potion_type.size()]
	order_length = randi_range(30, 45)
	order_viscosity = order_viscosity_type.keys()[randi() % order_viscosity_type.size()]
	print (order_type)
	print (order_viscosity)
