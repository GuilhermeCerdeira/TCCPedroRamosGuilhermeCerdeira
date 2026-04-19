extends ColorRect

class_name EndScreenTrainMode

@export var question : TextureRect
@export var label : Label

@export var gradient_bg : TextureRect

var lose_gradient : Resource = preload("res://challenges/prefabs/lose_gradient.tres")

func show_screen(win : bool, _question : CompressedTexture2D):
	get_tree().paused = true
	
	question.texture = _question
	
	show_top_label(win)
	
	if not win:
		gradient_bg.texture = lose_gradient

func show_top_label(win : bool):
	if win:
		label.text = "DESAFIO CONCLUIDO"
	else:
		label.text = "PERDEU!"

func _on_close_question_button_pressed():
	question.visible = false

func _on_show_question_button_pressed():
	question.visible = true

func close_window():
	get_tree().paused = false
	self.queue_free()

func _on_return_button_pressed():
	close_window()
