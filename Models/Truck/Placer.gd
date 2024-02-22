extends Node3D

@onready var interaction_area = $InteractionArea

var space_taken = false

var icecream_finished = false

signal move_cone(node, icecream_finished, cone)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	
	if Global.holding_cone and !space_taken:
		print (Global.player.hand.get_child(0).icecream_finished)
		space_taken = true
		move_cone.emit(self, Global.player.hand.get_child(0).icecream_finished, Global.player.hand.get_child(0))
	elif !Global.holding_cone and space_taken:
		print (self.get_child(1).icecream_finished)
		move_cone.emit(Global.player.hand, self.get_child(1).icecream_finished, self.get_child(1))
		space_taken = false
		
