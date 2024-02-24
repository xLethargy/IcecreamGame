extends Node

var total = 0:
	set(value):
		total = value


var holding_cone = false:
	set(value):
		holding_cone = value

@onready var player = get_tree().get_first_node_in_group("Player")
