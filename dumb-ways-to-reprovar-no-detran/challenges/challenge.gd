extends Node2D

class_name Challenge

@export var question : CompressedTexture2D

var particle : PackedScene = preload("res://challenges/prefabs/particle.tscn")

var right_texture : Texture2D = preload("res://images/check.png")
var wrong_texture : Texture2D = preload("res://images/xis.png")

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

func particle_emit(right : bool):
	var particle_instance = particle.instantiate() as CPUParticles2D
	if right:
		particle_instance.texture = right_texture
	else:
		particle_instance.texture = wrong_texture
	add_child(particle_instance)
	particle_instance.position = get_global_mouse_position()
	particle_instance.connect("finished", _on_particle_finished)
	particle_instance.emitting = true

func _on_particle_finished():
	pass

func win_points_default_value() -> int:
	return ((timer_instance.time_left/timer_instance.wait_time) + 0.25) * 100
