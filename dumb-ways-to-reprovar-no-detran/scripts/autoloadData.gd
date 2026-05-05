extends Node

var player_name = ""

var challenges : Array[PackedScene] = [
	preload("res://challenges_scenes/challenge1.tscn"),
	preload("res://challenges_scenes/challenge2.tscn"),
	preload("res://challenges_scenes/challenge3.tscn")
]

func get_random_challenge() -> Challenge:
	var scene : PackedScene = AutoloadData.challenges.pick_random()
	return scene.instantiate()
