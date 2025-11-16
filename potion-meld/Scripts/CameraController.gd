extends Camera3D

@export var left_transform: Vector3
@export var middle_transform: Vector3
@export var right_transform: Vector3
@export var left_y_rot: float
@export var middle_y_rot: float
@export var right_y_rot: float

@onready var customer_view = $"../HUD/CustomerView"

var target_transform
var target_rot
var curr_transform_x
var curr_transform_z
var curr_rot

#0 = left, 1 = middle, 2 = right
var state = 1
var lerp_val = 0
var moving = false

func _start() -> void:
	rotation.y = PI

func _process(delta: float) -> void:
	if !moving:
		if (Input.is_action_just_pressed("look_left")):
			curr_transform_x = position.x
			curr_transform_z = position.z
			curr_rot = rotation.y
			if state == 0:
				pass
			elif state == 1:
				target_transform = left_transform
				target_rot = deg_to_rad(left_y_rot)
				moving = true
				state = 0
			elif state == 2:
				target_transform = middle_transform
				target_rot = deg_to_rad(middle_y_rot)
				moving = true
				state = 1
			customer_view.hide_order_bubbles()
				
		if (Input.is_action_just_pressed("look_right")):
			curr_transform_x = position.x
			curr_transform_z = position.z
			curr_rot = rotation.y
			if state == 0:
				target_transform = middle_transform
				target_rot = deg_to_rad(middle_y_rot)
				moving = true
				state = 1
			elif state == 1:
				target_transform = right_transform
				target_rot = deg_to_rad(right_y_rot)
				moving = true
				state = 2
			elif state == 2:
				pass
			customer_view.hide_order_bubbles()
				
	else:
		lerp_val += delta
		rotation.y = lerp_angle(curr_rot, target_rot, lerp_val)
		position.x = lerp(curr_transform_x, target_transform.x, lerp_val)
		position.z = lerp(curr_transform_z, target_transform.z, lerp_val)
		if lerp_val > 1.0:
			moving = false
			lerp_val = 0
