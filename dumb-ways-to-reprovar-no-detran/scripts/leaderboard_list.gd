extends VBoxContainer
@export var entry_scene: PackedScene 

func _ready():
	if SimpleBoards: 
		SimpleBoards.entries_got.connect(_on_leaderboard_received)
		atualizar_ranking()

func atualizar_ranking():
	print(">>> Solicitando dados da API...")
	for child in get_children():
		child.queue_free()
		
	SimpleBoards.get_entries("b06851a0-d63d-48f0-5a2b-08de8c0e271a")

func _on_leaderboard_received(entries):
	print(">>> RESPOSTA DA API: Recebi ", entries.size(), " entradas.")
	
	if entries.size() == 0:
		print(">>> A lista está vazia no servidor.")
		return

	var rank_contador = 1

	for entry in entries:
		if entry_scene:
			var new_entry = entry_scene.instantiate()
			add_child(new_entry)
			
			var nome_jogador = entry.get("playerDisplayName", "Anônimo")
			var pontos = entry.get("score", 0)
			
			if new_entry.has_method("set_data"):
				new_entry.set_data(rank_contador, nome_jogador, pontos)
				
				rank_contador += 1
			else:
				print(">>> ERRO: Sua cena de entrada não tem a função 'set_data'")
