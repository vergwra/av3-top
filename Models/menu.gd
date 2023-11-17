extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Animacao.play("default");
	$AnimatedSprite2D2.play("default");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	print("CLÇICOU")
	Transition.fade_to_scene("res://Scenes/coverTwo.tscn")
