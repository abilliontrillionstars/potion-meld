extends Node3D

class_name NPC
	
var npc_order: NPCOrder
var npc_wait_timer: float
var next_destination: Vector3
var counter_spot_id: int

var movespeed = 5.0

var lifetime = 0.0
var moving = false
var roaming = false
var approached = false
var leaving = false

func _ready() -> void:
	npc_order = NPCOrder.new()
	npc_order.randomize_order()
	position.x = randf_range(-5, 5)
	position.z = randf_range(8.0, 9.0)
	npc_wait_timer = 30
	counter_spot_id = -1
	# randomize the robe color
	var color = Color(randf(),randf(),randf(), 1.0)
	$Body.modulate = color
	$Body/Arms.modulate = color
	
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
			NpcManager.occupy_counter_spot(counter_spot_id, self)
			#print ($"../World/HUD".name)
			$"../World/HUD/CustomerView".update_order_bubble(counter_spot_id, npc_order)
			moving = true
		else:
			moving = true
			next_destination = Vector3(randf_range(-5, 5), 0.0, randf_range(5.0, 9.0))
			lifetime -= randf_range(4.5, 6.5)
	if moving:
		var dir = (next_destination - position).normalized()
		position += dir * movespeed * delta
		if (next_destination - position).length() < 0.1:
			moving = false
			if leaving:
				queue_free()

func leave_counter():
	leaving = true
	moving = true
	NpcManager.free_counter_spot(counter_spot_id)
	counter_spot_id = -1
	next_destination = Vector3(randf_range(-0.5, 0.5), 0.0, randf_range(8, 9))