extends BaseWindow

class_name ChallengeModeController

@onready var end_screen : PackedScene = load("res://challenges/prefabs/end_screen.tscn")

var lives : int = 3
var points : int = 0
var dificulty : int = 0

func _ready():
	next_challenge()

func next_challenge():
	dificulty += 1
	var challenge : Challenge =  AutoloadData.get_random_challenge()
	challenge.setup(dificulty, get_time(dificulty))
	challenge.win.connect(_on_win)
	challenge.lose.connect(_on_lose)
	add_child(challenge)

func _on_win(challenge : Challenge, _points : int):
	points += _points
	show_end_screen(true, challenge.question)
	challenge.queue_free()

func _on_lose(challenge : Challenge):
	lives -= 1
	show_end_screen(false, challenge.question)
	challenge.queue_free()

func get_time(difficulty: int) -> float:
	var tempo_base = 7.0
	var fator = 0.9
	return tempo_base * pow(fator, difficulty)

func show_end_screen(win : bool, question : CompressedTexture2D):
	var end_screen_instance = end_screen.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.next_challenge.connect(next_challenge)
	end_screen_instance.count_points.connect(save_points_in_leaderboard)
	end_screen_instance.show_screen(win, question, lives, points)

func create_player_id():
	var player_id = AutoloadData.player_name.hash()
	return str(player_id)

func compare_scores() -> bool:
	var entries = await SimpleBoards.get_entries('b06851a0-d63d-48f0-5a2b-08de8c0e271a')
	if entries == null:
		return true
	var player_id = create_player_id()
	var existing_entry = null
	for entry in entries:
		print(entry.get('playerId'))
		if entry.get('playerId') == player_id:
			existing_entry = entry
			break
	if existing_entry == null:
		return true
	var old_score = int(existing_entry.get("score", 0))
	return points > old_score

func save_points_in_leaderboard():
	if await compare_scores():
		await SimpleBoards.send_score_with_id('b06851a0-d63d-48f0-5a2b-08de8c0e271a', AutoloadData.player_name, points, null, create_player_id())
	return_to_menu()
