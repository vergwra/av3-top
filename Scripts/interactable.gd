extends RigidBody3D

class_name interactable

var on_interact: Callable;

func _ready():
	pass 

func _process(delta):
	pass

func interact(sender: player):
	print("INTERACT WITH: " + self.name)
	if (on_interact.is_valid()):
		on_interact.bind(self).call();
	
func on_hover_interact():
	#print("Enter on " + self.name)
	pass

func on_exit_interact():
	#print("Exit on " + self.name)
	pass
