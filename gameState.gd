extends Node

var score = 0
var high_score = 0
var dead = false

func reset():
	score = 0
func save_to_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(str(high_score))

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file != null:
		high_score = int(file.get_as_text())
