extends Node2D

@export var name_input : LineEdit
@export var warning_name : Label

func _ready():
	name_input.text = AutoloadData.player_name

func _on_modo_desafio_button_pressed():
	if  save_name_autoload_data():
		get_tree().change_scene_to_file("res://scenes/challengemode.tscn")

func _on_modo_treino_button_pressed():
	AutoloadData.player_name = name_input.text
	get_tree().change_scene_to_file("res://scenes/trainingmode.tscn")

func _on_leaderboard_button_pressed():
	AutoloadData.player_name = name_input.text
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")

func _on_sair_button_pressed():
	get_tree().quit()

func save_name_autoload_data() -> bool:
	if name_input.text != "":
		AutoloadData.player_name = name_input.text
		return true
	
	warning_name.visible = true
	return false
