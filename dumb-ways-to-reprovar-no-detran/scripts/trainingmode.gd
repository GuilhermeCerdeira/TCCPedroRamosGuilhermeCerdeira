extends BaseWindow

class_name TrainingModeController

@export var container : VBoxContainer
@export var question_image : TextureRect

var challenge_coice_prefab : PackedScene = preload("res://challenges/prefabs/challenge_choice.tscn")

var challenge_choices : Array[ChallengeChoice]
var current_choice : ChallengeChoice = null

func _ready():
	var index : int = 1
	for challenge_scene in AutoloadData.challenges:
		var challenge_choice = challenge_coice_prefab.instantiate() as ChallengeChoice
		challenge_choices.append(challenge_choice)
		challenge_choice.connect("choice", _on_challenge_select)
		challenge_choice.challenge = challenge_scene.instantiate()
		challenge_choice.text = "Desafio " + str(index)
		index += 1
		container.add_child(challenge_choice)

func _on_challenge_select(challenge_choice : ChallengeChoice):
	current_choice = challenge_choice
	desselect_all_others_but_current()
	question_image.texture = challenge_choice.challenge.question
	pass

func desselect_all_others_but_current():
	for choice in challenge_choices:
		if current_choice != choice:
			choice.button_pressed = false

func _on_play_button_pressed():
	current_choice.play_challenge()

func _on_return_button_pressed():
	return_to_menu()
