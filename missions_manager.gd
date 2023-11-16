extends Node

class_name mission_manager

@export var missions: Array[mission];
var current_mission_index = 0;
var current_mission: mission;

var on_start_mission: Callable;
var on_complete_mission: Callable;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_mission_by_index();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start_mission_by_index():
	current_mission = missions[current_mission_index];
	setup_mission(current_mission)
	on_start_mission.bind(current_mission).call();
	
func setup_mission(_mission: mission):
	_mission.start_mission();
	_mission.on_complete = on_complete_current_mission;
	print("start mission " + _mission.mission_name)
	print(_mission.mission_desc);
	
func on_complete_current_mission(_mission: mission):
	print("mission " + _mission.name + " completed")
	on_complete_mission.bind(_mission).call();
