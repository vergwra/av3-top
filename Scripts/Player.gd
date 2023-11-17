extends CharacterBody3D

class_name player;

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.1

#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = $Head
@onready var camera = $Head/Camera3D

var on_hover_interactable: Callable;
var on_exit_interactable: Callable;

func _ready():
	active_input();
	
	
var input_activated = true;

func active_input():
	input_activated = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func desactivate_input():
	input_activated = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _process(delta):
	_check_interacting();

var y_rot = 0.0;
var x_rot = 0.0;
func _input(event):
	
	if (!input_activated):
		return;
	
	if event is InputEventMouseMotion:
		y_rot -= event.relative.x * SENSITIVITY;
		x_rot -= event.relative.y * SENSITIVITY;
		x_rot = clamp(x_rot, -89, 89);
		head.rotation_degrees.y = y_rot;
		camera.rotation_degrees.x = x_rot;
		#head.rotate_y(-event.relative.x * SENSITIVITY)
		#camera.rotate_x(clamp(-event.relative.y, -90, 90) * SENSITIVITY)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Vector2.ZERO;
	if (input_activated):
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		# Handle Sprint.
		if Input.is_action_pressed("sprint"):
			speed = SPRINT_SPEED
		else:
			speed = WALK_SPEED
			
		if (Input.is_action_just_pressed("interact")):
			_try_interact();
		# Get the input direction and handle the movement/deceleration.
		input_dir = Input.get_vector("left", "right", "up", "down")

	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
const RAY_LENGTH = 2.5;
var current_interacting: interactable = null;

func _try_interact():
	if (current_interacting != null):
		current_interacting.interact(self);
	else:
		print("Nao esta interagindo com nenhum objeto")

func _check_interacting():
	var space_state = get_world_3d().direct_space_state
	var cam = camera
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)

	if (result and result.collider is interactable):
		var _obj = result.collider as interactable;
		
		if (current_interacting != _obj):
			if (current_interacting != null):
				current_interacting.on_exit_interact()
			current_interacting = _obj
			current_interacting.on_hover_interact()
			if (on_hover_interactable.is_valid()):
				on_hover_interactable.bind(self).call();
	else:
		if (on_exit_interactable.is_valid()):
			on_exit_interactable.bind(self).call();
		if (current_interacting):
			current_interacting.on_exit_interact();
		current_interacting = null
	
