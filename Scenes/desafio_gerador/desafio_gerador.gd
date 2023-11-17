extends desafio

var resultado = 0;
@export var buttons: Array[desafio_button];

# Called when the node enters the scene tree for the first time.
func initialize(p: player):
	super.initialize(p);
	equacao();
	
func on_press_button(result: int):
	if (result == resultado):
		on_complete();
	
func equacao():
	var eq_str = "";
	var result = 0;
	
	var size = randi_range(2, 4);
	
	for i in range(size - 1):
		var n: int = randi_range(1, 10);
		eq_str += str(n);
		
		var op = randi_range(0, 3);
		
		if (op == 0):
			eq_str += " + "
		elif (op == 1):
			eq_str += " - "
		elif (op == 2):
			eq_str += " / "
		elif (op == 3):
			eq_str += " * "
	var n = randi_range(1, 10);
	eq_str += str(n);
	eq_str += ""
	var expression = Expression.new()
	expression.parse(eq_str);
	var _result = expression.execute();
	resultado = _result;
	print(resultado)
	
	var index_certo = randi_range(0, len(buttons) - 1);
	buttons[index_certo].initialize(resultado, on_press_button)
	var index = 0
	for _btn in buttons:	
		print(index)
		if (index == index_certo): 
			index += 1;
			continue;
		buttons[index].initialize(resultado - randi_range(-10, 10), on_press_button)
		index += 1;
	
	$Panel/pergunta.text = eq_str.replace("*", "x") + " = ?";
	
func on_complete():
	super.on_complete();
	_player.active_input();
