extends Node

@export var slot_displays: Array[TextureRect]
@export var ingredient_display: RichTextLabel

var dust_sprite = preload("res://Textures/dungeondust.png")
var eye_sprite = preload("res://Textures/eyeofnewt.png")
var grapes_sprite = preload("res://Textures/grapesofwrath.png")
var phoenix_sprite = preload("res://Textures/phoenixfeather.png")
var gelatinous_sprite = preload("res://Textures/gelatinouscubes.png")
var gloomweed_sprite = preload("res://Textures/gloomweed.png")
var elven_sprite = preload("res://Textures/elvenleaf.png")

@onready var camera_ref = $"../../Camera3D"
@onready var cauldron = $"../../cauldron"

var inv_slots_occupied = [false, false, false, false, false, false]
var inv_slot_ingredients = [null, null, null, null, null, null]
var hovered_shelf_slot: int = -1
var hovered_inv_slot:int = -1

func _process(delta: float) -> void:        
	if Input.is_action_just_pressed("MouseClicked"):
		#print (hovered_shelf_slot)
		#print (inv_slots_occupied[0])
		if hovered_shelf_slot != -1:
			var open_slot = get_next_open_slot()
			#print (open_slot)
			var ingr_type = null
			if open_slot != -1:
				if hovered_shelf_slot == 1:
					ingr_type = Ingredient.ingredient_type.DungeonDust
					slot_displays[open_slot].texture = dust_sprite
				elif hovered_shelf_slot == 2:
					ingr_type = Ingredient.ingredient_type.EyeOfNewt
					slot_displays[open_slot].texture = eye_sprite
				elif hovered_shelf_slot == 3:
					ingr_type = Ingredient.ingredient_type.GrapesOfWrath
					slot_displays[open_slot].texture = grapes_sprite
				elif hovered_shelf_slot == 4:
					ingr_type = Ingredient.ingredient_type.PhoenixFeather
					slot_displays[open_slot].texture = phoenix_sprite
				elif hovered_shelf_slot == 5:
					ingr_type = Ingredient.ingredient_type.GelatinousCubes
					slot_displays[open_slot].texture = gelatinous_sprite
				elif hovered_shelf_slot == 6:
					ingr_type = Ingredient.ingredient_type.GloomWeed
					slot_displays[open_slot].texture = gloomweed_sprite
				elif hovered_shelf_slot == 7:
					ingr_type = Ingredient.ingredient_type.ElvenLeaf
					slot_displays[open_slot].texture = elven_sprite
				inv_slot_ingredients[open_slot] = ingr_type
				inv_slots_occupied[open_slot] = true
				#print (ingr_type)

		if hovered_inv_slot != -1:
			if camera_ref.state == 0:
				#print (hovered_inv_slot)
				inv_slot_ingredients[hovered_inv_slot] = null
				inv_slots_occupied[hovered_inv_slot] = false
				slot_displays[hovered_inv_slot].texture = null

			if camera_ref.state == 2:
				cauldron.add_ingredient(inv_slot_ingredients[hovered_inv_slot])
				inv_slot_ingredients[hovered_inv_slot] = null
				inv_slots_occupied[hovered_inv_slot] = false
				slot_displays[hovered_inv_slot].texture = null
				print ("put dat shit in the cauldron !")


	if camera_ref.state == 0:
		var wave_bb = "[wave amp=30.0 freq=5.0 connected=1]"
		if hovered_shelf_slot == 1:
			ingredient_display.text = wave_bb + "Dungeon Dust [/wave]"
		elif hovered_shelf_slot == 2:
			ingredient_display.text = wave_bb + "Eye of Newt [/wave]"
		elif hovered_shelf_slot == 3:
			ingredient_display.text = wave_bb + "Grapes of Wrath [/wave]"
		elif hovered_shelf_slot == 4:
			ingredient_display.text = wave_bb + "Phoenix Feather [/wave]"
		elif hovered_shelf_slot == 5:
			ingredient_display.text = wave_bb + "Gelatinous Cubes [/wave]"
		elif hovered_shelf_slot == 6:
			ingredient_display.text = wave_bb + "Gloomweed [/wave]"
		elif hovered_shelf_slot == 7:
			ingredient_display.text = wave_bb + "Elven Leaf [/wave]"
		else:
			ingredient_display.text = ""
	else:
		ingredient_display.text = ""

func curr_slot_occupied():
	pass #return slots_occupied[hovered_slot]

func get_next_open_slot():
	for i in range(0, 6):
		if !inv_slots_occupied[i]:
			return i
	return -1

func occupy_curr_slot(slot_id, ingr_type):
	inv_slots_occupied[slot_id] = true
	inv_slot_ingredients[slot_id] = ingr_type

func clear_curr_slot(slot_id):
	inv_slots_occupied[slot_id] = false

func _on_shelf_slot_1_mouse_entered() -> void:
	hovered_shelf_slot = 1
	#print (hovered_shelf_slot)

func _on_shelf_slot_2_mouse_entered() -> void:
	hovered_shelf_slot = 2
	#print (hovered_shelf_slot)

func _on_shelf_slot_3_mouse_entered() -> void:
	hovered_shelf_slot = 3
	#print (hovered_shelf_slot)

func _on_shelf_slot_4_mouse_entered() -> void:
	hovered_shelf_slot = 4
	#print (hovered_shelf_slot)

func _on_shelf_slot_5_mouse_entered() -> void:
	hovered_shelf_slot = 5
	#print (hovered_shelf_slot)

func _on_shelf_slot_6_mouse_entered() -> void:
	hovered_shelf_slot = 6
	#print (hovered_shelf_slot)

func _on_shelf_slot_7_mouse_entered() -> void:
	hovered_shelf_slot = 7
	#print (hovered_shelf_slot)

func _on_shelf_slot_mouse_exited() -> void:
	hovered_shelf_slot = -1
	#print (hovered_shelf_slot)
