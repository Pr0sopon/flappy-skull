extends Control
var normal_scale = Vector2(1, 1)
var pressed_scale = Vector2(0.9, 0.9)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer.visible = false
	$Control.visible = false
	$Control.returned.connect(return_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func return_button():
	$Control.visible = false
	$MarginContainer.visible = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			if $MarginContainer.visible == true:
				_on_resume_pressed()
			else:
				$Control.visible = false
				$MarginContainer.visible = true
		else:
			_on_button_pressed()


func _on_button_pressed() -> void:
	if GameState.dead == false:
		ButtonSound.play()
		$MarginContainer2/Button.scale = pressed_scale
		get_tree().paused = true
		$MarginContainer.visible = true
		$MarginContainer2.visible = false
	

func _on_resume_pressed() -> void:
	ButtonSound.play()
	get_tree().paused = false
	$MarginContainer.visible = false
	$MarginContainer2/Button.scale = normal_scale
	$MarginContainer2.visible = true


func _on_exit_pressed() -> void:
	ButtonSound.play()
	get_tree().paused = false
	if GameState.score > GameState.high_score:
		GameState.high_score = GameState.score
		GameState.reset()
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_settings_pressed() -> void:
	ButtonSound.play()
	$MarginContainer.visible = false
	$Control.visible = true
