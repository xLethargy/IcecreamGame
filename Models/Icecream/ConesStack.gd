extends StaticBody3D

@onready var interaction_area = $InteractionArea

var cones : Array = []

var stack_index = 0

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	for child in self.get_children():
		if child.is_in_group("Cones"):
			cones.append(child)
			


func _on_interact():
	cones[0].cones[stack_index].visible = false
	stack_index += 1
	if stack_index == cones[0].amount:
		queue_free()
