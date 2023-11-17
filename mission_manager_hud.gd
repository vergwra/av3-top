extends Control

class_name mission_manager_hud

@export var manager: mission_manager = null;

var status = "HIDE";

# Called when the node enters the scene tree for the first time.
func _ready():
	manager.on_start_mission = on_start_mission;
	manager.on_complete_mission = on_complete_mission;
	manager.on_complete_all_missions = on_complete_all_missions;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (status == "SHOW"):
		$mission_name.modulate.a = lerp($mission_name.modulate.a, 1.0, 4 * delta);
		$mission_desc.modulate.a = lerp($mission_name.modulate.a, 1.0, 4 * delta);
	elif(status == "HIDE"):
		$mission_name.modulate.a = lerp($mission_name.modulate.a, 0.0, 4 * delta);
		$mission_desc.modulate.a = lerp($mission_name.modulate.a, 0.0, 4 * delta);
	else:
		$mission_name.modulate.a = lerp($mission_name.modulate.a, 1.0, 4 * delta);
		$mission_desc.modulate.a = lerp($mission_desc.modulate.a, 0.0, 4 * delta);

func on_change_mission_status(_m: mission):
	$mission_name.text =_m.mission_name + " " + _m.get_status();

func on_start_mission(_m: mission):
	status = "SHOW";
	$mission_name.text = _m.mission_name + " " + _m.get_status();
	$mission_desc.text = _m.mission_desc;
	_m.on_add_quantity = on_change_mission_status;
	
func on_complete_mission(_m: mission):
	status = "HIDE";
	
func on_complete_all_missions():
	status = "COMPLETED";
	$mission_name.text = "Voce ganhou!"

	
