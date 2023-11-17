extends Control

@export var _player: player;

# Called when the node enters the scene tree for the first time.
func _ready():
	$crosshair.visible = false;
	_player.on_hover_interactable = on_hover_interactable;
	_player.on_exit_interactable = on_exit_interactable;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_hover_interactable(p: player):
	$crosshair.visible = true;
func on_exit_interactable(p: player):
	$crosshair.visible = false;
