extends interactable

class_name door

var openned: bool = false;
var target_rotation: float = 0.0;

var on_open: Callable;

func _process(delta):
	rotation_degrees.y = lerp(rotation_degrees.y, target_rotation, 10 * delta);
	
func interact(sender: Node3D):
	var z_vector = global_transform.basis.z
	var relative_pos = sender.global_transform.origin - global_transform.origin

	var dot = z_vector.dot(relative_pos)
	
	openned = !openned;
	handle_door_status(dot)
	
func handle_door_status(dot: float):
	if (openned):
		if (on_open.is_valid()):
			on_open.bind(self).call()
		target_rotation = 90 if dot > 0 else -90;
	else:
		target_rotation = 0;
		
	
	
