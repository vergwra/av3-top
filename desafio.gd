extends Node

class_name desafio

var on_complete_desafio: Callable;
var on_fail_desafio: Callable;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false;

var _player: player = null;
func initialize(p: player):
	self.visible = true;
	_player = p;
	
func on_complete():
	self.visible = false;
	if (on_complete_desafio.is_valid()):
		on_complete_desafio.bind(self).call();
	
func on_fail():
	if (on_fail_desafio.is_valid()):
		on_fail_desafio.bind(self).call();
