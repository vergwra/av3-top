extends Node

class_name mission_manager

@export var missions: Array[mission];
var current_mission_index = 0;
var current_mission: mission;
var current_time = 0.0;

var on_start_mission: Callable;
var on_complete_mission: Callable;
var on_complete_all_missions: Callable;
var on_failed: Callable;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_mission_by_index();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_time > 0:
		current_time -= delta;
	elif current_mission != null:
		if (on_failed.is_valid()):
			on_failed.call();
	
func start_mission_by_index():
	current_mission = missions[current_mission_index];

	setup_mission(current_mission)
	
	if (on_start_mission.is_valid()):
		on_start_mission.bind(current_mission).call();

func start_next_mission():
	var new_index = current_mission_index + 1;
	if (new_index >= len(missions)):
		complete_all_missions();
		return;
		
	current_mission_index = new_index
	start_mission_by_index();

func complete_all_missions():
	print(" COMPLETE ALL MISSIONS")
	if (on_complete_all_missions.is_valid()):
		on_complete_all_missions.bind().call();

func setup_mission(_mission: mission):
	current_time = _mission.mission_time;
	_mission.start_mission();
	_mission.on_complete = on_complete_current_mission;
	
func on_complete_current_mission(_mission: mission):
	print("mission " + _mission.name + " completed")
	if (on_complete_mission.is_valid()):
		on_complete_mission.bind(_mission).call();
	start_next_mission();
