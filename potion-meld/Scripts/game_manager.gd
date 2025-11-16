extends Node

var player_score = 0

@onready var player_score_label = $"../World/HUD/PlayerScore/ScoreLabel"
@onready var customer_view = $"../World/HUD/CustomerView"

func _ready() -> void:
	print (player_score_label.name)

func add_player_score(amt: int):
	player_score += amt
	player_score_label.text = "[wave amp=20.0 freq=2.0 connected=1]Score: " + str(player_score) + "[/wave]"

func get_potion_type(ingr1, ingr2):
	if ((ingr1 == 0 and ingr2 == 1) or (ingr1 == 1 and ingr2 == 0)):
		return "DarkVision"
	elif ((ingr1 == 0 and ingr2 == 2) or (ingr1 == 2 and ingr2 == 0)):
		return "Thorns"
	elif ((ingr1 == 0 and ingr2 == 3) or (ingr1 == 3 and ingr2 == 0)):
		return "FeignDeath"
	elif ((ingr1 == 0 and ingr2 == 4) or (ingr1 == 4 and ingr2 == 0)):
		return "Fortitude"
	elif ((ingr1 == 0 and ingr2 == 5) or (ingr1 == 5 and ingr2 == 0)):
		return "Poison"
	elif ((ingr1 == 0 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 0)):
		return "Slowfall"
	elif ((ingr1 == 1 and ingr2 == 2) or (ingr1 == 2 and ingr2 == 1)):
		return "SlowPotion"
	elif ((ingr1 == 1 and ingr2 == 3) or (ingr1 == 3 and ingr2 == 1)):
		return "Dangersense"
	elif ((ingr1 == 1 and ingr2 == 4) or (ingr1 == 4 and ingr2 == 1)):
		return "Sleep"
	elif ((ingr1 == 1 and ingr2 == 5) or (ingr1 == 5 and ingr2 == 1)):
		return "Truesight"
	elif ((ingr1 == 1 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 1)):
		return "Intelligence"
	elif ((ingr1 == 2 and ingr2 == 3) or (ingr1 == 3 and ingr2 == 2)):
		return "Haste"
	elif ((ingr1 == 2 and ingr2 == 4) or (ingr1 == 4 and ingr2 == 2)):
		return "Strength"
	elif ((ingr1 == 2 and ingr2 == 5) or (ingr1 == 5 and ingr2 == 2)):
		return "Gills"
	elif ((ingr1 == 2 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 2)):
		return "Stealth"
	elif ((ingr1 == 3 and ingr2 == 4) or (ingr1 == 4 and ingr2 == 3)):
		return "Healing"
	elif ((ingr1 == 3 and ingr2 == 5) or (ingr1 == 5 and ingr2 == 3)):
		return "Focus"
	elif ((ingr1 == 3 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 3)):
		return "Wings"
	elif ((ingr1 == 4 and ingr2 == 5) or (ingr1 == 5 and ingr2 == 4)):
		return "Growth"
	elif ((ingr1 == 4 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 4)):
		return "Stoneskin"
	elif ((ingr1 == 5 and ingr2 == 6) or (ingr1 == 6 and ingr2 == 5)):
		return "Agility"

func attempt_deliver_potion(ingr1, ingr2):
	var potion_type = get_potion_type(ingr1, ingr2)
	print (potion_type)
	for i in range(0, NpcManager.counter_npcs.size()):
		if NpcManager.counter_npcs[i]:
			if NpcManager.counter_npcs[i].npc_order.order_type == potion_type:
				GameManager.add_player_score(clamp((40 * (NpcManager.counter_npcs[i].lifetime/ NpcManager.counter_npcs[i].npc_wait_timer)), 0, 9999) + 10)
				customer_view.hide_order_bubble(i)
				NpcManager.counter_npcs[i].leave_counter()
				print ("found a match, award player points")
			#print (NpcManager.npcs[i].npc_order.order_type)
