extends Node

var npc_scene = preload("res://Scenes/PackedScenes/npc.tscn")
var npcs = []
var spawn_timer = 0.0
var time_to_spawn_next = randi_range(10, 20)
var first_npc = false
var counter_spots_avail = [true, true, true]
var counter_spots = [Vector3(2.5, 0.0, 4.0), Vector3(0.0, 0.0, 4.0), Vector3(-2.5, 0.0, 4.0)]

func _init() -> void:
	pass
	#AddNPC()

func _process(delta: float) -> void:
	spawn_timer += delta
	if !first_npc:
		if spawn_timer > 1.0:
			AddNPC()
			first_npc = true
	if spawn_timer > time_to_spawn_next:
		time_to_spawn_next = randi_range(20, 30)
		spawn_timer = 0.0
		AddNPC()
	
func AddNPC():
	var new_npc = npc_scene.instantiate() as NPC
	get_parent().add_child(new_npc)
	new_npc.npc_id = npcs.size()
	npcs.append(npc_scene.instantiate())
	
func get_next_open_counter_spot():
	if counter_spots_avail[1]:
		return [1, counter_spots[1]]
	elif counter_spots_avail[0]:
		return [0, counter_spots[0]]
	elif counter_spots_avail[2]:
		return [2, counter_spots[2]]
	else:
		return [-1, null]
		
func occupy_counter_spot(spot_id: int, npc_id: int):
	counter_spots_avail[spot_id] = false
