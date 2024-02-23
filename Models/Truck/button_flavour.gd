extends MeshInstance3D

@onready var interaction_area = $InteractionArea

@onready var chocolate_flavour = preload("res://Materials/chocolate.tres")
@onready var strawberry_flavour = preload("res://Materials/strawberry.tres")
@onready var blueberry_flavour = preload("res://Materials/blueberry.tres")

var flavour

func _ready():
	flavour = self.mesh.material
	
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	$"../..".icecream_flavour = flavour
	$"../..".change_flavour(flavour)
