extends CharacterBody3D

var speed : float = 5
var jump_velocity : float = 4.5
var fall_speed : float = 15

@onready var neck = $Neck
@onready var camera = $Neck/Camera3D
var sensitivity : float = 0.005

var collider = null

var called : bool = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		neck.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _process(delta: float) -> void:
	_raycasting_interaction()
	

func _raycasting_interaction():
	if $Neck/RayCast3D.get_collider() != null:
		collider = $Neck/RayCast3D.get_collider()
		if collider.is_in_group("Interactable") and !called:
			collider.call_register_area() # test
			called = true
	elif collider != null and called:
		collider.call_unregister_area()
		called = false

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= fall_speed * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
