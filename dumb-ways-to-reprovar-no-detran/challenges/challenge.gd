extends Node

class_name Challenge

@export var question : CompressedTexture2D

var timer_scene : PackedScene = preload("res://challenges/prefabs/timer.tscn")
var progress_bar_scene : PackedScene = preload("res://challenges/prefabs/progress_bar.tscn")

var timer_instance : Timer
var progress_bar_instance : ProgressBarChallenge

var difficulty
var time

signal win(challenge : Challenge, points : int)
signal lose(challenge : Challenge)

func setup(_difficulty : int, _time : float):
	difficulty = _difficulty
	time = _time
	
	timer_instance = timer_scene.instantiate()
	timer_instance.timeout.connect(_on_timeout)
	timer_instance.wait_time = time
	
	progress_bar_instance = progress_bar_scene.instantiate()
	progress_bar_instance.set_timer(timer_instance)

func _ready():
	add_child(timer_instance)
	add_child(progress_bar_instance)
	
	timer_instance.start()

func _process(_delta):
	pass

func _on_timeout():
	pass
