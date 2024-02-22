extends Label3D



func _process(delta):
	self.text = "[E] to " + %InteractionArea.action_name
	var player_position = get_tree().get_first_node_in_group("Player").global_position
	player_position.y = get_global_transform().origin.y
	look_at(player_position)
	self.rotate_object_local(Vector3(0,1,0), 3.14)
