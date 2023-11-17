extends mission


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_mission():
	super.start_mission();
	var geradores = get_tree().get_nodes_in_group("geradores")

	for i in geradores:
		if i is gerador:
			i.on_interact = handle_on_interact;

var is_on = false;
func handle_on_interact(_g: gerador):
	if (is_on):
		return;
	is_on = true;
	add_quantity();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
