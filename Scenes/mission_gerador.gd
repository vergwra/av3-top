extends mission

func start_mission():
	super.start_mission();
	var geradores = get_tree().get_nodes_in_group("geradores")
	for i in geradores:
		if i is gerador:
			i.on_completed_desafio = handle_on_complete_desafio;

func handle_on_complete_desafio():
	print("DESAFIO DFOI COMPLETADO")
	add_quantity();
