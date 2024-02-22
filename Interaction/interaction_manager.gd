extends Node3D

@onready var player = get_tree().get_first_node_in_group("Player")

const base_text = "[E] to "

var can_interact = false

var active_area

func register_area(area):
	active_area = area
	can_interact = true
	

func unregister_area():
	can_interact = false


func _input(event: InputEvent) -> void:
	if event.is_action("interact") && can_interact:
		#print (active_area.message)
		active_area.interact.call()
	
	if event.is_action_released("interact") or !can_interact:
		if active_area != null:
			active_area.interact_released.call()
		
