extends ColorRect

class_name EndScreen

@export var question : TextureRect
@export var label : Label

@export var life_container : HBoxContainer
@export var num_points_label : Label

@export var show_question_button : Button
@export var next_challenge_button : Button
@export var count_points_button : Button

@export var gradient_bg : TextureRect

var lose_gradient : Resource = preload("res://challenges/prefabs/lose_gradient.tres")

signal count_points
signal next_challenge

func _enter_tree():
	await get_tree().create_timer(1).timeout
	show_question_button.disabled = false
	next_challenge_button.disabled = false
	count_points_button.disabled = false

func show_screen(win : bool, _question : CompressedTexture2D, lives : int, points: int):
	get_tree().paused = true
	
	question.texture = _question
	
	show_top_label(win, lives)
	
	show_lives(lives)
	
	num_points_label.text = str(points)
	
	if not win:
		gradient_bg.texture = lose_gradient

func show_top_label(win : bool, lives : int):
	if win:
		label.text = "DESAFIO CONCLUÍDO"
	elif lives > 0:
		label.text = "PERDEU!"
	else:
		label.text = "ACABARAM SUAS VIDAS!"
		next_challenge_button.visible = false
		count_points_button.visible = true

func show_lives(lives : int):
	var children = life_container.get_children()
	for i in range(children.size()):
		if i + 1 > lives:
			var child = children[i] as TextureRect
			child.modulate = Color(0.0, 0.0, 0.0, 1.0)

func _on_close_question_button_pressed():
	question.visible = false

func _on_show_question_button_pressed():
	question.visible = true

func _on_next_challenge_button_pressed():
	next_challenge.emit()
	close_window()

func _on_count_points_button_pressed():
	close_window()
	count_points.emit()

func close_window():
	get_tree().paused = false
	self.queue_free()
