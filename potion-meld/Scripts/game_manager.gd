extends Node

var player_score = 0
@onready var player_score_label = $"../World/HUD/PlayerScore/ScoreLabel"

var recipes: Dictionary[String, Array] = RecipeBook.recipes

func _ready() -> void:
	pass
	#print (player_score_label.name)

func add_player_score(amt: int):
	player_score += amt
	player_score_label.text = "[wave amp=20.0 freq=2.0 connected=1]Score: " + str(player_score) + "[/wave]"

func get_potion_type(ingr1, ingr2):
	for potion in recipes.keys():
		var recipe = recipes[potion]
		if ingr1 in recipe and ingr2 in recipe:
			return potion
			
func attempt_deliver_potion(ingr1, ingr2):
	var potion_type = get_potion_type(ingr1, ingr2)
	print (potion_type)
	for i in range(0, NpcManager.counter_npcs.size()):
		if NpcManager.counter_npcs[i]:
			if NpcManager.counter_npcs[i].npc_order.order_type == potion_type:
				GameManager.add_player_score(clamp((40 * (NpcManager.counter_npcs[i].lifetime/ NpcManager.counter_npcs[i].npc_wait_timer)), 0, 9999) + 10)
				NpcManager.counter_npcs[i].leave_counter()
				print ("found a match, award player points")
			#print (NpcManager.npcs[i].npc_order.order_type)
