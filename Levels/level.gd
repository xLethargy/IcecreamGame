extends Node3D

var cone_scene = preload("res://Models/Icecream/cone.tscn")

func _ready():
	for cone in get_tree().get_nodes_in_group("Cone"):
		cone.connect("move_cone", _on_cone_move)

func _on_cone_place(cone_position, placer, icecream_finished):
	var cone = cone_scene.instantiate()
	if icecream_finished:
		cone.get_child(2).visible = true
	placer.add_child(cone)


func _on_cone_move(parent_node, icecream_finished, old_cone):
	print ("running")
	
	old_cone.queue_free()
	
	if parent_node.name == "Hand":
		Global.holding_cone = true
	else:
		Global.holding_cone = false
	
	var cone = cone_scene.instantiate()
	if icecream_finished:
		cone.get_child(2).visible = true
	parent_node.add_child(cone)
	cone.connect("move_cone", _on_cone_move)
	
