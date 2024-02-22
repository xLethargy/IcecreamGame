extends Node3D

@onready var interaction_area = $InteractionArea

var icecream_finished = false

signal move_cone(node, icecream_finished, cone)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _process(delta):
	if $Icecream.visible:
			icecream_finished = true


func _on_interact():
	if !Global.holding_cone:
		move_cone.emit(Global.player.hand, icecream_finished, self)
		get_parent().space_taken = false
