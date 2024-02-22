extends Node3D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = []
var can_interact = false

var active_area

func register_area(area):
	active_area = area
	label.text = base_text + area.action_name
	label.show()
	can_interact = true
	

func unregister_area():
	active_area = null
	label.hide()
	can_interact = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		print (active_area.message)
		active_area.interact.call()
