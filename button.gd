extends Button

var normal_scale = Vector2(1, 1)
var hover_scale = Vector2(1.1, 1.1)


func _ready() -> void:
	self.pivot_offset = self.size/2
	self.connect("mouse_entered",_on_mouse_entered)  
	self.connect("mouse_exited",_on_mouse_exited)
	
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	self.scale = hover_scale

func _on_mouse_exited() -> void:
	self.scale = normal_scale
	
	
