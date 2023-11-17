extends Button

class_name desafio_button

var on_click: Callable;

func initialize(result: int, _on_click: Callable):
	on_click = _on_click.bind(result);
	self.text = str(result);

func _on_pressed():
	on_click.call();
