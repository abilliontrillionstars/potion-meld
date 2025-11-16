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

func _ready() -> void:
    set_cauldron_color(Color(0.6, 0.0, 0.0, 1.0))
    #liquid_mat.set("shader_parameter/albedo", Color(0.6, 0.0, 0.0, 1.0))

func _process(delta: float) -> void:
    if updating_color:
        color_lerp += delta / 5.0
        liquid_mat.set("shader_parameter/albedo", Color(lerp(liquid_color.r, desired_color.r, color_lerp), lerp(liquid_color.g, desired_color.g, color_lerp), lerp(liquid_color.b, desired_color.b, color_lerp), 255))
        if color_lerp > 1.0:
            updating_color = false
            color_lerp = 0.0
            liquid_color = desired_color

    if Input.is_action_just_pressed("ChangeColor"):
        set_cauldron_color(Color(0.1, 0.6, 0.2, 1.0))

func set_cauldron_color(new_color: Color):
    updating_color = true
    desired_color = new_color