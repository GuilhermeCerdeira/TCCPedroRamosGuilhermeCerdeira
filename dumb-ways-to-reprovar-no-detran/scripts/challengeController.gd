extends Node2D

@export var challenges : Array[PackedScene]
@onready var end_screen : PackedScene = load("res://challenges/prefabs/end_screen.tscn")

var lives : int = 3
var points : int = 0
var dificulty : int = 0

func _ready():
	next_challenge()

func next_challenge():
	dificulty += 1
	var challenge : Challenge =  get_random_challenge()
	challenge.setup(dificulty, get_time(dificulty))
	challenge.win.connect(_on_win)
	challenge.lose.connect(_on_lose)
	add_child(challenge)

func get_random_challenge() -> Challenge:
	var scene : PackedScene = challenges.pick_random()
	return scene.instantiate()

func _on_win(challenge : Challenge, _points : int):
	points += _points
	show_end_screen(true, challenge.question)
	challenge.queue_free()

func _on_lose(challenge : Challenge):
	lives -= 1
	show_end_screen(false, challenge.question)
	challenge.queue_free()

func get_time(difficulty: int) -> float:
	var tempo_base = 7.0
	var fator = 0.9
	return tempo_base * pow(fator, difficulty)

func show_end_screen(win : bool, question : CompressedTexture2D):
	var end_screen_instance = end_screen.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.next_challenge.connect(next_challenge)
	end_screen_instance.count_points.connect(save_points_in_leaderboard)
	end_screen_instance.show_screen(win, question, lives, points)

func save_points_in_leaderboard():
	## INSERT ENTRY IN LEADERBOARD
	## GET POINTS FROM "points"
	## GET PLAYER NAME FROM "AutoloadData.player_name"
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
