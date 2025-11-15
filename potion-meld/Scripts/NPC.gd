extends Node3D

class_name NPC
	
var npc_order: NPCOrder
var npc_wait_timer: float
var next_destination: Vector3
var counter_spot_id: int

var movespeed = 5.0

var lifetime = 0.0
var moving = false
var approached = false

func _ready() -> void:
	npc_order = NPCOrder.new()
	npc_order.randomize_order()
	position.x = randf_range(-5, 5)
	position.z = randf_range(8.0, 9.0)
	var node = get_child(0) as Sprite3D
	get_child(2).play("NPCArms")
	get_child(1).play("NPCAppear")
	
func _process(delta: float) -> void:
	lifetime += delta
	if lifetime > 1.0 and !approached:
		var counter_info = NpcManager.get_next_open_counter_spot()
		if counter_info[0] != -1:
			approached = true
			counter_spot_id = counter_info[0]
			next_destination = counter_info[1]
			NpcManager.occupy_counter_spot(counter_spot_id)
			moving = true
		else:
			lifetime -= 5.0
	if moving:
		var dir = (next_destination - position).normalized()
		position += dir * movespeed * delta
		#next_destination = Vector3(randi_range(-1, 1))
