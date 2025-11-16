extends Control

@export var left_order_bubble: Control
@export var middle_order_bubble: Control
@export var right_order_bubble: Control

@export var order_hitboxes: Array[Panel]

@export var type_texts: Array[RichTextLabel]
@export var viscosity_texts: Array[RichTextLabel]

@onready var camera_ref = $"../../Camera3D"

func _on_left_customer_mouse_entered() -> void:
	if !NpcManager.counter_spots_avail[0] and camera_ref.state == 1:
		left_order_bubble.visible = true
		print (camera_ref.name)
		#print ("show left customer order if counter spot taken")

func _on_middle_customer_mouse_entered() -> void:
	if !NpcManager.counter_spots_avail[1] and camera_ref.state == 1:
		middle_order_bubble.visible = true
		print (camera_ref.name)
		#print ("show middle customer order if counter spot taken")

func _on_right_customer_mouse_entered() -> void:
	if !NpcManager.counter_spots_avail[2] and camera_ref.state == 1:
		right_order_bubble.visible = true
		#print ("show right customer order if counter spot taken")

func _on_left_customer_mouse_exited() -> void:
	if !NpcManager.counter_spots_avail[0]:
		left_order_bubble.visible = false
		#print ("hide left customer order if counter spot taken")

func _on_middle_customer_mouse_exited() -> void:
	if !NpcManager.counter_spots_avail[1]:
		middle_order_bubble.visible = false
		#print ("hide middle customer order if counter spot taken")

func _on_right_customer_mouse_exited() -> void:
	if !NpcManager.counter_spots_avail[2]:
		right_order_bubble.visible = false
		#print ("hide right customer order if counter spot taken")

func _ready() -> void:
	pass

func update_order_bubble(bubble_id: int, order_info: NPCOrder):
	type_texts[bubble_id].text = "Potion of " + order_info.order_type
	var visc_text = ""
	if order_info.order_viscosity == "VeryThin":
		visc_text = "Very Thin (1-20%)"
	elif order_info.order_viscosity == "Thin":
		visc_text = "Thin (21-40%)"
	elif order_info.order_viscosity == "Normal":
		visc_text = "Regular (41-60%)"
	elif order_info.order_viscosity == "Thick":
		visc_text = "Thick (61-80%)"
	elif order_info.order_viscosity == "VeryThick":
		visc_text = "Very Thick (81-100%)"

	viscosity_texts[bubble_id].text = "\n\n\n" + visc_text

func hide_order_bubbles():
	left_order_bubble.visible = false
	middle_order_bubble.visible = false
	right_order_bubble.visible = false

func hide_order_hitboxes():
	print ("hiding hitboxes")
	for i in range(0, order_hitboxes.size()):
		order_hitboxes[i].mouse_filter = Control.MOUSE_FILTER_IGNORE

func show_order_hitboxes():
	print ("showing hitboxes")
	for i in range(0, order_hitboxes.size()):
		order_hitboxes[i].mouse_filter = Control.MOUSE_FILTER_STOP
