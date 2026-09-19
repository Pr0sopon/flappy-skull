extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
