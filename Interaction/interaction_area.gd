extends Area3D
class_name InteractionArea

@export var action_name : String = "interact"
@export var message : String = "enter message"

var interact : Callable = func():
	pass

var interact_released : Callable = func():
	pass


func call_register_area():
	%Label.show()
	InteractionManager.register_area(self)


func call_unregister_area():
	%Label.hide()
	InteractionManager.unregister_area()
