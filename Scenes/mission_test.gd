extends mission


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_mission():
	super.start_mission();
	var doors = get_tree().get_nodes_in_group("doors")
	openned_doors = [];
	for i in doors:
		if i is door:
			i.on_open = handle_open_door;

var openned_doors: Array[door] = []

func handle_open_door(openned_door: door):
	if (openned_door in openned_doors):
		return
	
	openned_doors.append(openned_door);
	add_quantity();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
