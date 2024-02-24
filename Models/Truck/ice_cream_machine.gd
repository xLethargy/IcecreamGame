extends StaticBody3D

@onready var interaction_area = %InteractionArea
@onready var animation_player = $AnimationPlayer

var reheld = false



signal move_cone(node, icecream_finished, cone, flavour)

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.interact_released = Callable(self, "_on_interact_released")

var icecream_flavour

func _on_interact():
	
	if !animation_player.is_playing():
		$HeldCheckTimer.start()
		play_dispense_start_held()
	else:
		reheld = true

func _on_interact_released():
	reheld = false
	if animation_player == null:
		return
	
	if animation_player.is_playing() and animation_player.current_animation == "icecream_end" or !animation_player.is_playing():
		return
	
	if animation_player.is_playing() and animation_player.current_animation == "icecream_dispense":
		await animation_player.animation_finished
		if reheld:
			play_dispense_flow()
			return
	elif animation_player.is_playing() and animation_player.current_animation == "icecream_flow":
		animation_player.stop()

	play_dispense_end()

func play_dispense_start():
	animation_player.play("icecream_dispense")

func play_dispense_end():
	animation_player.play("icecream_end")
	await animation_player.animation_finished
	$HeldCheckTimer.stop()
	$Icecream/DispensedIcecream.set_surface_override_material(0, icecream_flavour)

func play_dispense_start_held():
	play_dispense_start()
	await animation_player.animation_finished
	play_dispense_flow()

func play_dispense_flow():
	animation_player.play("icecream_flow")

func show_label():
	%Label.show()

func hide_label():
	%Label.hide()

#node, icecream_finished, cone, flavour

func _on_held_check_timer_timeout():
	if $Placer.space_taken:
		var icecream = $Placer.get_child(2)
		if !icecream.icecream_single.visible:
			move_cone.emit($Placer, true, icecream, $Icecream/DispensedIcecream.get_surface_override_material(0))


func change_flavour(flavour):
	if !animation_player.is_playing():
		$Icecream/DispensedIcecream.set_surface_override_material(0, flavour)
