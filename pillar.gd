extends StaticBody2D

signal score
@onready var timer = $Timer




func _on_area_2d_body_entered(body: Node2D) -> void:
	score.emit()
