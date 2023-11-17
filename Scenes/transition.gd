extends CanvasLayer

var new_scene := ""

func fade_to_scene(_new_scene: String) -> void:
	new_scene = _new_scene
	$AnimationPlayer.play("fade")

func change_scene() -> void:
	get_tree().change_scene_to_file(new_scene)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
