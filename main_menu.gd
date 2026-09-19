extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control.visible = false
	GameState.load_from_file()
	$MarginContainer2/VBoxContainer/Label.text = str(GameState.high_score)
	$Control.returned.connect(return_button)


func return_button():
	$Control.visible = false
	$MarginContainer2.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	ButtonSound.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	ButtonSound.play()
	$MarginContainer2.visible = false
	$Control.visible = true
