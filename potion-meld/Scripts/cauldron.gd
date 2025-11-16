extends Node3D

@export var liquid: MeshInstance3D
var liquid_mat = preload("res://Materials/LiquidMaterial.tres") as ShaderMaterial

var liquid_color = Color(0.6, 0.6, 0.6, 1.0)
var current_progress: float
var finished = false
var finished_timer = 0.0
var resetting = false
var heat: float
var ingredient1 = -1
var ingredient2 = -1
var ingredient1_color
var ingredient2_color

var desired_color: Color
var updating_color = false
var color_lerp = 0.0
@onready var liquid_anim = $"LiquidAnim"

@onready var camera_ref = $"../Camera3D"
@onready var stirrer = $stirrer
@onready var cauldron_label_1 = $"../HUD/CauldronLabel1" as RichTextLabel
@onready var cauldron_label_2 = $"../HUD/CauldronLabel2" as RichTextLabel
@onready var cauldron_label_3 = $"../HUD/CauldronLabel3" as RichTextLabel
var label_1_shown = false
var label_2_shown = false
var label_3_shown = false

var can_stir = false
var stirring = false
var stir_speed = 0.0
var stir_angle = 0.0 #radians
var last_mouse_x = 0.0

func _ready() -> void:
	set_cauldron_color(Color(0.6, 0.6, 0.6, 1.0))
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

	if current_progress > 200 and !finished:
		finish_potion()
	
	stirrer.position.x = cos(deg_to_rad(stir_angle)) / 1.8
	stirrer.position.z = sin(deg_to_rad(stir_angle)) / 1.8
	stirrer.rotation.y = deg_to_rad(-stir_angle) - 0.5
	
	last_mouse_x = get_viewport().get_mouse_position().x

	if ingredient1 != -1 and ingredient2 != -1:
		current_progress += stir_speed / 1000
	

	if Input.is_action_just_pressed("ChangeColor"):
		set_cauldron_color(Color(0.1, 0.6, 0.2, 1.0))
		GameManager.add_player_score(50)

	if Input.is_action_just_pressed("MouseClicked"):
		if can_stir and camera_ref.state == 2:
			stirring = true
			
	if Input.is_action_just_released("MouseClicked"):
		if stirring:
			stirring = false

	if finished:
		finished_timer += delta
		if finished_timer >= 1.0 and !resetting:
			resetting = true
			liquid_anim.play("LiquidFlush")
			cauldron_label_3.visible = true
			var bb_code = "[wave amp=20.0 freq=2.0 connected=1]"
			var potion = GameManager.get_potion_name(ingredient1, ingredient2)
			cauldron_label_3.text = bb_code + potion + "[/wave]"


func set_cauldron_color(new_color: Color):
	color_lerp = 0.0
	liquid_color = liquid_mat.get("shader_parameter/albedo")
	updating_color = true
	desired_color = new_color
	liquid_anim.play("LiquidSplash")


#DungeonDust, EyeOfNewt, GrapesOfWrath, PhoenixFeather, GelatinousCubes, GloomWeed, ElvenLeaf
func add_ingredient(ingr_type):
	$"../SoundManager/CauldronBubble".playing = true
	var bb_code = "[wave amp=20.0 freq=2.0 connected=1]"
	if ingredient1 == -1:
		var ingr = GameManager.get_ingr_name(ingr_type)
		cauldron_label_1.visible = true
		cauldron_label_1.text = bb_code + ingr + "[/wave]"
		ingredient1 = ingr_type
		ingredient1_color = get_ingr_color(ingr_type)
		cauldron_label_1.modulate = ingredient1_color
	elif ingredient2 == -1:
		cauldron_label_2.visible = true
		cauldron_label_2.text = bb_code + GameManager.get_ingr_name(ingr_type) + "[/wave]"
		ingredient2 = ingr_type
		ingredient2_color = get_ingr_color(ingr_type)
		cauldron_label_2.modulate = ingredient2_color
	else:
		print ("tell player cauldron is too full")

	print (ingr_type)
	set_cauldron_color(get_ingr_color(ingr_type))

func _on_stirrer_dragbox_mouse_entered() -> void:
	can_stir = true

func _on_stirrer_dragbox_2_mouse_exited() -> void:
	can_stir = false

func finish_potion():
	$"../SoundManager/CauldronBubble".playing = false
	$"../SoundManager/PotionPoof".play()
	finished = true
	current_progress = 0.0
	print ("finished stirring potion")
	var blend_color = Color((ingredient1_color.r + ingredient2_color.r) / 2, (ingredient1_color.g + ingredient2_color.g) / 2, (ingredient1_color.b + ingredient2_color.b) / 2, 1.0)
	print (ingredient2_color)
	print (blend_color)
	set_cauldron_color(blend_color)


func reset_cauldron():
	GameManager.attempt_deliver_potion(ingredient1, ingredient2)
	finished = false
	resetting = false
	finished_timer = 0.0
	current_progress = 0.0
	ingredient1 = -1
	ingredient2 = -1
	cauldron_label_1.visible = false
	cauldron_label_2.visible = false
	liquid_mat.set("shader_parameter/albedo", Color(0.5, 0.5, 0.5, 1.0))

func hide_potion_name():
	cauldron_label_3.visible = false

func get_ingr_color(ingr_type):
	match ingr_type:
		0: #"DungeonDust":
			return (Color(0.3411,0.2666,0.2,1.0))
		1: #"EyeOfNewt":
			return (Color(0.8941,0.9019,0.2627,1.0))
		2: #"GrapesOfWrath":
			return (Color(0.6823,0.4353,0.604,1.0))
		3: #"PhoenixFeather":
			return (Color(0.651,0.047,0.047,1.0))
		4: #"GelatinousCubes":
			return (Color(0.31,0.8745,0.7451,1.0))
		5: #"GloomWeed":
			return (Color(0.557,0.2352,0.91,1.0))
		6: #"ElvenLeaf":
			return (Color(0.251,0.357,0.2352,1.0))
