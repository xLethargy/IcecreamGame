extends Node3D

@onready var player = get_tree().get_first_node_in_group("Player")

const base_text = "[E] to "

var can_interact = false

var active_area

func register_area(area):
	active_area = area
	can_interact = true
	

func unregister_area(area):
	can_interact = false


func _input(event: InputEvent) -> void:
	if active_area != null:
		if event.is_action("interact") and can_interact and active_area.is_in_group("Button"):
			#print (active_area.message)
			active_area.interact.call()
		
		if event.is_action_pressed("interact") and can_interact and !active_area.is_in_group("Button"):
			active_area.interact.call()
	
	if event.is_action_released("interact") or !can_interact:
		if active_area != null:
			active_area.interact_released.call()
