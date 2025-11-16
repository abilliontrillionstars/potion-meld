extends Node

class_name RecipeBook

const ingr = Ingredient.ingredient_type
const recipes: Dictionary[String, Array] = {
	"Thorns" : [ingr.DungeonDust, ingr.GrapesOfWrath],
	"Feign Death" : [ingr.DungeonDust, ingr.PhoenixFeather],
	"Fortitude" : [ingr.DungeonDust, ingr.GelatinousCubes],
	"Poison" : [ingr.DungeonDust, ingr.GloomWeed],
	"Slow Falling" : [ingr.DungeonDust, ingr.ElvenLeaf],
	"Darkvision" : [ingr.DungeonDust, ingr.EyeOfNewt],

	"Slow" : [ingr.EyeOfNewt, ingr.GrapesOfWrath],
	"Dangersense" : [ingr.EyeOfNewt, ingr.PhoenixFeather],
	"Slumber" : [ingr.EyeOfNewt, ingr.GelatinousCubes],
	"True Sight" : [ingr.EyeOfNewt, ingr.GloomWeed],
	"Intelligence" : [ingr.EyeOfNewt, ingr.ElvenLeaf],

	"Haste" : [ingr.GrapesOfWrath, ingr.PhoenixFeather],
	"Strength" : [ingr.GrapesOfWrath, ingr.GelatinousCubes],
	"Gills" : [ingr.GrapesOfWrath, ingr.GloomWeed],
	"Stealth" : [ingr.GrapesOfWrath, ingr.ElvenLeaf],

	"Healing" : [ingr.PhoenixFeather, ingr.GelatinousCubes],
	"Focus" : [ingr.PhoenixFeather, ingr.GloomWeed],
	"Wings" : [ingr.PhoenixFeather, ingr.ElvenLeaf],

	"Growth" : [ingr.GelatinousCubes, ingr.GloomWeed],
	"Stoneskin" : [ingr.GelatinousCubes, ingr.ElvenLeaf],
	
	"Agility" : [ingr.GloomWeed, ingr.ElvenLeaf],
}


const ingredient_colors = {
	"DungeonDust": Color(87,68,51,255),
	"GrapesOfWrath": Color(174,111,154,255),
	"ElvenLeaf": Color(64,91,60,255),
	"GloomWeed": Color(142,60,232,255),
	"GelatinousCubes": Color(79,223,190,255),
	"EyeOfNewt": Color(228,230,67,255),
	"PhoenixFeather": Color(166,12,12,255),
}
