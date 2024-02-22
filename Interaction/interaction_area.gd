extends Area3D
class_name InteractionArea

@export var action_name : String = "interact"
@export var message : String = "enter message"

var interact : Callable = func():
	pass


func call_register_area():
	InteractionManager.register_area(self)


func call_unregister_area():
	InteractionManager.unregister_area()
