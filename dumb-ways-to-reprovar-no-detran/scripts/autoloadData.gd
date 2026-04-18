extends Node

var player_name = ""

var challenges : Array[PackedScene]

func _ready():
	load_challenges()

func load_challenges():
	var dir = DirAccess.open("res://challenges_scenes")
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var scene = load("res://challenges_scenes/" + file_name)
				challenges.append(scene)
			
			file_name = dir.get_next()
		
		dir.list_dir_end()
