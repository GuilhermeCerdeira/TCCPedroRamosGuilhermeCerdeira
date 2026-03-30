extends Node2D

@export var challenges : Array[PackedScene]

var lives : int = 3
var points : int = 0
var dificulty : int = 1

func _ready():
	next_challenge()

func next_challenge():
	var challenge : Challenge =  get_random_challenge()
	challenge.setup(dificulty, get_time(dificulty))
	add_child(challenge)
	challenge.win.connect(_on_win)
	challenge.lose.connect(_on_lose)

func get_random_challenge() -> Challenge:
	var scene : PackedScene = challenges.pick_random()
	return scene.instantiate()

func _on_win(challenge : Challenge, _points : int):
	points += _points
	challenge.queue_free()

func _on_lose(challenge : Challenge, ):
	lives -= 1
	challenge.queue_free()

func get_time(difficulty: int) -> float:
	var tempo_base = 7.0
	var fator = 0.9
	return tempo_base * pow(fator, difficulty)
