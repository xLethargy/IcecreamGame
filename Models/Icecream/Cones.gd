extends Node3D

var cones : Array
var amount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for cone in self.get_children():
		cones.append(cone)
		amount += 1
