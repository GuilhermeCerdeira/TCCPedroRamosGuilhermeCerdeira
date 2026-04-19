extends BaseWindow

class_name LeaderboardController

@export var entry_scene: PackedScene 
@export var container: VBoxContainer

func _ready():
	if SimpleBoards: 
		SimpleBoards.entries_got.connect(_on_leaderboard_received)
		atualizar_ranking()

func atualizar_ranking():
	print(">>> Solicitando dados da API...")
	for child in container.get_children():
		child.queue_free()
		
	SimpleBoards.get_entries("b06851a0-d63d-48f0-5a2b-08de8c0e271a")

func _on_leaderboard_received(entries):
	if entries.size() == 0:
		return

	var rank_contador = 1

	for entry in entries:
		if entry_scene:
			var new_entry = entry_scene.instantiate()
			container.add_child(new_entry)
			
			var nome_jogador = entry.get("playerDisplayName", "Anônimo")
			var pontos = entry.get("score", 0)
			
			if new_entry.has_method("set_data"):
				new_entry.set_data(rank_contador, nome_jogador, pontos)
				
				rank_contador += 1

func _on_return_button_pressed():
	return_to_menu()

func _on_refresh_button_pressed():
	atualizar_ranking()
