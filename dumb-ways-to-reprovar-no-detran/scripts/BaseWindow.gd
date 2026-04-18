extends Node2D

class_name BaseWindow

func return_to_menu():
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
