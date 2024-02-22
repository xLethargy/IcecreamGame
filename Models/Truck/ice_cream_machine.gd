extends StaticBody3D

@onready var interaction_area = %InteractionArea

var reheld = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.interact_released = Callable(self, "_on_interact_released")



func _on_interact():
	if !$AnimationPlayer.is_playing():
		$HeldCheckTimer.start()
		play_dispense_start_held()
	else:
		reheld = true

func _on_interact_released():
	reheld = false
	if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "icecream_end" or !$AnimationPlayer.is_playing():
		return
	
	if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "icecream_dispense":
		await $AnimationPlayer.animation_finished
		if reheld:
			play_dispense_flow()
			return
	elif $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "icecream_flow":
		$AnimationPlayer.stop()

	play_dispense_end()

func play_dispense_start():
	$AnimationPlayer.play("icecream_dispense")

func play_dispense_end():
	$AnimationPlayer.play("icecream_end")
	await $AnimationPlayer.animation_finished
	$HeldCheckTimer.stop()

func play_dispense_start_held():
	play_dispense_start()
	await $AnimationPlayer.animation_finished
	play_dispense_flow()

func play_dispense_flow():
	$AnimationPlayer.play("icecream_flow")

func show_label():
	%Label.show()

func hide_label():
	%Label.hide()



func _on_held_check_timer_timeout():
	if $Placer.space_taken:
		var icecream = $Placer.get_child(1).get_child(2)
		icecream.visible = true
		$Placer.icecream_finished = true
