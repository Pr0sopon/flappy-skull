extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	$AnimatedSprite2D.frame = 0
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("fade_out")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://main.tscn")
