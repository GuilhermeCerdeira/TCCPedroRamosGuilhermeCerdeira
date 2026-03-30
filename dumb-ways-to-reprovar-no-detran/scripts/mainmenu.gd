extends Node2D

func _on_modo_desafio_button_pressed():
	get_tree().change_scene_to_file("res://scenes/challengemode.tscn")

func _on_modo_treino_button_pressed():
	get_tree().change_scene_to_file("res://scenes/trainingmode.tscn")

func _on_leaderboard_button_pressed():
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")

func _on_sair_button_pressed():
	get_tree().quit()
