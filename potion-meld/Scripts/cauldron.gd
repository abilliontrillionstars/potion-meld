extends Node3D

@export var liquid: MeshInstance3D
var liquid_mat = preload("res://Materials/LiquidMaterial.tres") as ShaderMaterial

var liquid_color = Color(0.6, 0.6, 0.6, 1.0)
var current_progress: float
var heat: float
var ingredient1: Ingredient
var ingredient2: Ingredient

var desired_color: Color
var updating_color = false
var color_lerp = 0.0
@onready var liquid_anim = $"LiquidAnim"

@onready var camera_ref = $"../Camera3D"
@onready var stirrer = $stirrer

var can_stir = false
var stirring = false
var stir_speed = 0.0
var stir_angle = 0.0 #radians
var last_mouse_x = 0.0

func _ready() -> void:
	set_cauldron_color(Color(0.6, 0.0, 0.0, 1.0))
	#liquid_mat.set("shader_parameter/albedo", Color(0.6, 0.0, 0.0, 1.0))

func _process(delta: float) -> void:
	if updating_color:
		color_lerp += delta / 2.0
		liquid_mat.set("shader_parameter/albedo", Color(lerp(liquid_color.r, desired_color.r, color_lerp), lerp(liquid_color.g, desired_color.g, color_lerp), lerp(liquid_color.b, desired_color.b, color_lerp), 255))
		if color_lerp > 1.0:
			updating_color = false
			color_lerp = 0.0
			liquid_color = desired_color
			
	var mouse_diff = get_viewport().get_mouse_position().x - last_mouse_x
	if stirring:
		stir_speed += abs(mouse_diff)
	stir_speed = lerp (stir_speed, 0.0, 0.05)
	
	stir_angle += stir_speed * delta
	
	stirrer.position.x = cos(deg_to_rad(stir_angle)) / 1.8
	stirrer.position.z = sin(deg_to_rad(stir_angle)) / 1.8
	stirrer.rotation.y = deg_to_rad(-stir_angle) - 0.5
	
	last_mouse_x = get_viewport().get_mouse_position().x

	current_progress += stir_speed / 1000
	

	if Input.is_action_just_pressed("ChangeColor"):
		set_cauldron_color(Color(0.1, 0.6, 0.2, 1.0))

	if Input.is_action_just_pressed("MouseClicked"):
		if can_stir and camera_ref.state == 2:
			stirring = true
			
	if Input.is_action_just_released("MouseClicked"):
		if stirring:
			stirring = false

func set_cauldron_color(new_color: Color):
	updating_color = true
	desired_color = new_color
	liquid_anim.play("LiquidSplash")

func _on_stirrer_dragbox_mouse_entered() -> void:
	can_stir = true

func _on_stirrer_dragbox_2_mouse_exited() -> void:
	can_stir = false
