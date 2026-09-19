extends Node2D

@export var pillar_scene : PackedScene
@onready var ground1 = $Ground
@onready var ground2 = $Ground2
var game_over_shader : ShaderMaterial
var sprite
var PILLAR_DELAY = 100
var PILLAR_RANGE = 50
var SCROLL_SPEED = 50
var pillars : Array
var screen_size : Vector2i
var ss
var pixel_size
var ground_height : int
var scroll = 0
var g_running : bool
var g_over : bool
var score : int
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PillarTimer.start()
	sprite = $Camera2D/CanvasLayer/ColorRect
	game_over_shader = sprite.material
	ss = get_viewport().get_size()
	sprite.material = null
	sprite.visible = false
	screen_size = get_viewport().get_visible_rect().size
	ground_height = ground1.get_node("Sprite2D").texture.get_height()
	new_game()
	

func new_game():
	g_running = false
	g_over = false
	score = 0
	scroll = 0
	pillars.clear()
	generate_pillar()
	#$Player.reset()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll += SCROLL_SPEED * delta
	var g1_width = ground1.get_node("Sprite2D").texture.get_width()
	ground1.position.x = -scroll
	ground2.position.x = -scroll +g1_width
	if scroll >= g1_width:
		scroll = 0
	for pillar in pillars:
		pillar.position.x -= SCROLL_SPEED * delta
	


func _on_pillar_timer_timeout() -> void:
	generate_pillar()

func generate_pillar():
	var pillar = pillar_scene.instantiate()
	pillar.position.x = screen_size.x + PILLAR_DELAY
	pillar.position.y = (screen_size.y - ground_height)/2 + randi_range(-PILLAR_RANGE,PILLAR_RANGE)
	pillar.score.connect(increase_score)
	add_child(pillar)
	print("Generating pillar at ", pillar.position)
	pillars.append(pillar)
	
func game_stop():
	$PillarTimer.stop()
	
func increase_score():
	if(alive):
		GameState.score += 1;
		$CanvasLayer/MarginContainer/Label.text = str(GameState.score)
	

func _on_player_hit() -> void:
	alive = false
	print("HIT")
	SCROLL_SPEED = 0
	sprite.visible = true
	sprite.material = game_over_shader
	game_over_shader.set_shader_parameter("pixel_size",lerp(game_over_shader.get_shader_parameter("pixel_size"),50.0,0.1))
	if GameState.score > GameState.high_score:
		GameState.high_score = GameState.score
		GameState.save_to_file()
	GameState.reset()
	GameState.dead = true
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
