extends Node3D

@onready var interaction_area = $InteractionArea
@onready var icecream_single = $Icecream

var icecream_finished = false

signal move_cone(node, icecream_finished, cone, flavour)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _process(_delta):
	if icecream_single.visible:
		icecream_finished = true


func _on_interact():
	if !Global.holding_cone:
		move_cone.emit(Global.player.hand, icecream_finished, self, $Icecream.get_surface_override_material(0))
		get_parent().space_taken = false
