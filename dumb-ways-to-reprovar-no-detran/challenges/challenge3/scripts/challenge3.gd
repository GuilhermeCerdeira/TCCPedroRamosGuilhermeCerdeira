extends Challenge

var breaks : bool = false
var lights : bool = false

func _ready():
	super._ready()
	
func _on_timeout():
	lose.emit(self)
	
func check_win_condition():
	if breaks and lights:
		win.emit(self, (timer_instance.time_left/timer_instance.wait_time) * 100)

func _on_breakbutton_pressed() -> void:
	print("break button pressed")
	breaks = true
	check_win_condition()

func _on_lightbutton_pressed() -> void:
	print("light button pressed")
	lights = true
	check_win_condition()
