extends Node

class_name Ingredient

enum ingredient_type { DungeonDust, EyeOfNewt, GrapesOfWrath, PhoenixFeather, GelatinousCubes, GloomWeed, ElvenLeaf, }
var type: ingredient_type
var color: Color

func _ready() -> void:
    var key = ingredient_type.keys()[randi() % ingredient_type.size()]
    type = ingredient_type[key]

    if type == 0:
        color = Color(223, 149, 96, 255)
    elif type == 1:
        color = Color(66, 100, 210, 255)
    elif type == 2:
        color = Color(169, 66, 210, 255)
    elif type == 3:
        color = Color(210, 87, 66, 255)
    elif type == 4:
        color = Color(97, 205, 90, 255)