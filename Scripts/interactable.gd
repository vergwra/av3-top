extends RigidBody3D

class_name interactable

func _ready():
	pass 

func _process(delta):
	pass

func interact(sender: Node3D):
	print("INTERACT WITH: " + self.name)
	
func on_hover_interact():
	#print("Enter on " + self.name)
	pass

func on_exit_interact():
	#print("Exit on " + self.name)
	pass
