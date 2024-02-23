extends CharacterBody3D

@onready var chocolate_icecream_single = preload("res://UI/Icecreams/icecream_chocolate_want.png")
@onready var strawberry_icecream_single = preload("res://UI/Icecreams/icecream_strawberry_want.png")
@onready var blueberry_icecream_single = preload("res://UI/Icecreams/icecream_blueberry_want.png")

@onready var icecreams : Array = [chocolate_icecream_single, strawberry_icecream_single, blueberry_icecream_single]

@onready var chocolate_flavour = preload("res://Materials/chocolate.tres")
@onready var strawberry_flavour = preload("res://Materials/strawberry.tres")
@onready var blueberry_flavour = preload("res://Materials/blueberry.tres")

@onready var icecreams_flavour : Array = [chocolate_flavour, strawberry_flavour, blueberry_flavour]

@onready var interaction_area = $InteractionArea

var wanted_flavour
var random_number

signal move_cone(node, icecream_finished, cone)

func _ready():
	random_number = randi() % 3
	$Want/WantSprite.texture = icecreams[random_number]
	wanted_flavour = icecreams_flavour[random_number]
	
	interaction_area.interact = Callable(self, "_on_interact")



func _on_interact():
	if Global.holding_cone and Global.player.hand.get_child(0).icecream_finished:
		var icecream_cone = Global.player.hand.get_child(0)
		if icecream_cone.icecream_finished and icecream_cone.icecream_single.get_surface_override_material(0) == wanted_flavour:
			move_cone.emit(null, false, icecream_cone, null)
			random_number = randi() % 3
			$Want/WantSprite.texture = icecreams[random_number]
			wanted_flavour = icecreams_flavour[random_number]
	
