extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -90
signal hit
var velocity = Vector2(100,100)
@onready var collision = $CollisionShape2D
@onready var _ani_entrail = $Entrail
@onready var _ani_eye = $Eye
@export var squelch : Array[AudioStream]
@onready var audio = $AudioStreamPlayer
var can_input = true

func play_random_squelch():
	if squelch.size() == 0:
		return
	var index = randi() % squelch.size()
	audio.stream = squelch[index]
	audio.play()
	
func _ready() -> void:
	self.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	max_contacts_reported = 100
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and can_input:
			var fall_frame = _ani_entrail.frame
			var rise_start = clamp(4 - fall_frame,0,4)
			if(_ani_entrail.animation != "rise"):
				linear_velocity.y = JUMP_VELOCITY
				_ani_entrail.play("rise")
				_ani_entrail.frame = rise_start
				_ani_eye.play("rise")
				if _ani_entrail.frame >=2:
					audio.stream = squelch[1]
					audio.play()
				else:
					play_random_squelch()
				$GPUParticles2D.emitting = true
				$GPUParticles2D.restart()
	
func _physics_process(delta: float) -> void:
	if(can_input):
		linear_velocity.x = 0
		if linear_velocity.y >= 0 and _ani_entrail.animation != "fall":
			_ani_entrail.play("fall")
			_ani_eye.play("fall")

	
func dead(delta):
	can_input = false
	self.freeze = false
	$Entrail.stop()
	$Eye.stop()
	var shape = collision.shape
	shape.extents.x *= 1.09
	shape.extents.y *= 1.28
	collision.shape = shape
	linear_velocity = velocity*delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("pillar"):
		hit.emit()
		dead(get_physics_process_delta_time())
