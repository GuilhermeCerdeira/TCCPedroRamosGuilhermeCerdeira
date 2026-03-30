extends ColorRect

@export var question : TextureRect

func _on_close_question_button_pressed():
	question.visible = false

func _on_show_question_button_pressed():
	question.visible = true

func _on_replay_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
