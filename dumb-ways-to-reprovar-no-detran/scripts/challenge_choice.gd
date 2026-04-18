extends Button

class_name ChallengeChoice

var end_screen_scene : PackedScene = preload("res://challenges/prefabs/end_screen_train_mode.tscn")

var challenge : Challenge # original
var challenge_copy : Challenge # copy, to add and remove from the scene

signal choice(challengeChoice : ChallengeChoice)

func play_challenge():
	challenge_copy = challenge.duplicate()
	
	challenge_copy.setup(1, 5)
	challenge_copy.win.connect(_on_win)
	challenge_copy.lose.connect(_on_lose)
	
	get_tree().root.add_child(challenge_copy)

func show_end_screen(win : bool):
	var end_screen = end_screen_scene.instantiate() as EndScreenTrainMode
	get_tree().root.add_child(end_screen)
	end_screen.show_screen(win, challenge.question)
	#show end screen
	challenge_copy.queue_free()

func _on_win(_challenge : Challenge, _points : int):
	show_end_screen(true)
	
func _on_lose(_challenge : Challenge):
	show_end_screen(false)

func _on_pressed():
	choice.emit(self)
