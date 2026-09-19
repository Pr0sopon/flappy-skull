extends Control

@onready var eye = $TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()  # relative to this Control
	var max_distance = 1
	var dir = (mouse_pos - eye.position)
	if dir.length() > max_distance:
		dir = dir.normalized() * max_distance
	eye.position = eye.position + dir * delta * 20
