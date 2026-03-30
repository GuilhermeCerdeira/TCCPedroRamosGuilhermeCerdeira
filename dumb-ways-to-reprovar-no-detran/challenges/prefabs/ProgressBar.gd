extends ProgressBar

class_name ProgressBarChallenge

var timer : Timer

func _ready():
	max_value = timer.wait_time

func _process(_delta):
	value = timer.wait_time - timer.time_left

func set_timer(_timer : Timer):
	timer = _timer
