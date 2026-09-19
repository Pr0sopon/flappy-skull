extends AnimatedSprite2D

var eye_pos = Vector2(264,75)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var rel = mouse_pos - eye_pos
	if rel.x >= 0 and rel.y <= 0: #top-right
		frame = 2 
	elif rel.x < 0 and rel.y <= 0: #top-left
		frame = 1 
	elif rel.x < 0 and rel.y > 0: #bottom-left
		frame = 0 
	elif rel.x >= 0 and rel.y > 0: #bottom-right
		frame = 3 
