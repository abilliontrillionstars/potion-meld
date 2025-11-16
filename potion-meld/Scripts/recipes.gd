extends Node

# enum ingredient_type { 
	#DungeonDust, EyeOfNewt, GrapesOfWrath, 
	#PhoenixFeather, GelatinousCubes, GloomWeed, ElvenLeaf, 
#}
var ingr = Ingredient.ingredient_type

var recipes = {
	"thorns" : [ingr.DungeonDust, ingr.GrapesOfWrath],
	"feign death" : [ingr.DungeonDust, ingr.PhoenixFeather],
	"fortitude" : [ingr.DungeonDust, ingr.GelatinousCubes],
	"poison" : [ingr.DungeonDust, ingr.GloomWeed],
	"slow falling" : [ingr.DungeonDust, ingr.ElvenLeaf],
	"darkvision" : [ingr.DungeonDust, ingr.EyeOfNewt],

	"slow" : [ingr.EyeOfNewt, ingr.GrapesOfWrath],
	"dangersense" : [ingr.EyeOfNewt, ingr.PhoenixFeather],
	"sleep" : [ingr.EyeOfNewt, ingr.GelatinousCubes],
	"true sight" : [ingr.EyeOfNewt, ingr.GloomWeed],
	"intelligence" : [ingr.EyeOfNewt, ingr.ElvenLeaf],

	"haste" : [ingr.GrapesOfWrath, ingr.PhoenixFeather],
	"strength" : [ingr.GrapesOfWrath, ingr.GelatinousCubes],
	"gills" : [ingr.GrapesOfWrath, ingr.GloomWeed],
	"stealth" : [ingr.GrapesOfWrath, ingr.ElvenLeaf],

	"healing" : [ingr.PhoenixFeather, ingr.GelatinousCubes],
	"agility" : [ingr.ElvenLeaf, ingr.GloomWeed],
	"wings" : [ingr.PhoenixFeather, ingr.ElvenLeaf],

	"growth" : [ingr.GelatinousCubes, ingr.GloomWeed],
	"stoneskin" : [ingr.GelatinousCubes, ingr.ElvenLeaf],
}
var ingredient_colors = {
	"DungeonDust": Color(87,68,51,255),
	"GrapesOfWrath": Color(174,111,154,255),
	"ElvenLeaf": Color(64,91,60,255),
	"GloomWeed": Color(142,60,232,255),
	"gelatinous cubes": Color(79,223,190,255),
	"EyeOfNewt": Color(228,230,67,255),
	"PhoenixFeather": Color(166,12,12,255),
}
var potion_colors = {
	"slow" : Color(23,31,94,255),
	"intelligence" : Color(74,152,277,255),
	"fortitude" : Color(134,109,45,255), 
	"darkvision": Color(63,192,91,255),
	"slow fall": Color(166,233,198,255),
	"poison" : Color(107,149,75,255),
	"sleep" : Color(172,114,237,255),
	"haste" : Color(219,181,20,255),
	"strength" : Color(186,64,105,255),
	"stone skin" : Color(100,100,100,255),
	"true sight" : Color(235,66,73,255),
	"feign death" : Color(75,76,42,255),
	"wings" : Color(189,240,233,255),
	"healing" : Color(128,17,24,255),
	"growth": Color(224,193,24,255),
	"agility": Color(205,205,205,255),
	"stealth": Color(52,52,52,255),
	"focus": Color(202,50,101,255),
	"gills": Color(126,183,228,255),
	"dangersense": Color(241,231,144,255),
	"thorns": Color(36,69,50,255)
}
