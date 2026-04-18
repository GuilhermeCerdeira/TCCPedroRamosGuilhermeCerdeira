extends Challenge

@export var pedal : Sprite2D
@export var stick : Sprite2D

@export var pointer_animation_player : AnimationPlayer
@export var gauge_animation_player : AnimationPlayer
@export var stick_animation_player : AnimationPlayer

@export var up_sound : AudioStreamPlayer2D
@export var down_sound : AudioStreamPlayer2D
@export var rev_low_sound : AudioStreamPlayer2D
@export var rev_high_sound : AudioStreamPlayer2D

var pedal_tex_1 : Texture2D = load("res://challenges/challenge1/images/clutch_1.png")
var pedal_tex_2 : Texture2D = load("res://challenges/challenge1/images/clutch_2.png")

var stick_tex_1 : Texture2D = load("res://challenges/challenge1/images/shift_1.png")
var stick_tex_2 : Texture2D = load("res://challenges/challenge1/images/shift_2.png")

var clutch_in : bool = false

func _on_button_toggled(toggled_on):
	clutch_in = toggled_on
	if clutch_in:
		pedal.texture = pedal_tex_2
		pointer_animation_player.play("clutchin")
		gauge_animation_player.stop()
		
		rev_high_sound.stop()
		down_sound.play()
	else:
		pedal.texture = pedal_tex_1
		pointer_animation_player.play("start_banging")
		gauge_animation_player.play("warning")
		
		rev_low_sound.stop()
		up_sound.play()

func _on_pointer_animation_player_animation_finished(anim_name):
	if anim_name == "start_banging":
		pointer_animation_player.play("banging")
		gauge_animation_player.play("warning")

func _on_stick_button_button_down():
	if clutch_in:
		stick.frame = 1
		particle_emit(true)
	else:
		stick_animation_player.play("wrong")
		particle_emit(false)

func _on_timeout():
	check_win_condition()
	# or
	lose.emit(self)

func _on_down_finished():
	rev_low_sound.play()

func _on_up_finished():
	rev_high_sound.play()

func _on_particle_finished():
	check_win_condition()
	
func check_win_condition():
	if clutch_in and stick.frame == 1:
		win.emit(self, win_points_default_value())
