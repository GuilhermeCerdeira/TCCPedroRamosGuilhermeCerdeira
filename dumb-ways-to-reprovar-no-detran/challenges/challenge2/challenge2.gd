extends Challenge

@export var label_teste : Label

func _ready():
	super._ready()

func _process(_delta):
	label_teste.text = "Diff: " + str(difficulty) + " MaxTime: " +  str(timer_instance.time_left)

func _on_win_button_pressed():
	win.emit(self, 100)

func _on_lose_button_pressed():
	lose.emit(self)

func _on_timeout():
	lose.emit(self)
