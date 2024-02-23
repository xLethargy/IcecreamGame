extends Node3D

@onready var interaction_area = $InteractionArea

var space_taken = false

var icecream_finished = false

signal move_cone(node, icecream_finished, cone, flavour)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if Global.holding_cone and !space_taken:
		space_taken = true
		move_cone.emit(self, Global.player.hand.get_child(0).icecream_finished, Global.player.hand.get_child(0), Global.player.hand.get_child(0).icecream_single.get_surface_override_material(0))
	elif !Global.holding_cone and space_taken:
		move_cone.emit(Global.player.hand, self.get_child(2).icecream_finished, self.get_child(2), self.get_child(2).icecream_single.mesh.material)
		space_taken = false
		
