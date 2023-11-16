extends Node

class_name mission

@export var mission_name = "mission_name"
@export var mission_desc = "coma 3 pau e meio de merda"
@export var mission_time = 60
@export var target_quantity = 3;

var on_complete: Callable
var current_quantity = 0;

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_mission():
	pass

func add_quantity():
	current_quantity += 1;
	print_status()
	check_finish()

func print_status():
	print(str(current_quantity) + "/" + str(target_quantity));

func check_finish():
	if (current_quantity >= target_quantity):
		complete();

func complete():
	if (on_complete.is_valid()):
		on_complete.bind(self).call();
