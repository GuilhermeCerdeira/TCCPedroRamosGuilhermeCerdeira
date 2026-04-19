extends ColorRect

func set_data(rank, player_name, score):
	%Rank.text = "#" + str(rank)
	%Name.text = player_name
	%Score.text = str(score)
