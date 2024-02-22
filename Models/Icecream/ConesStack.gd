extends StaticBody3D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print ("cone")
