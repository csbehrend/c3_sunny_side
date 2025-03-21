extends Node2D

var animating = false #ChatGPT
var knife_max_x = 1625
var rock_max_x = 1600
var rock_start_x = 500
var knife_start_x = 350
var speed = 0

var margin_error = 30
var correct_lines = 0

var level_speed
var num_lines

var line = load("res://scenes/Cutting/line.tscn")
var x_posn = []

var game_started = false

func mock_start(difficultySpeed, difficultyNumLines):
	num_lines = difficultyNumLines
	level_speed = difficultySpeed
	minigame_start()

func _ready() -> void:
	match (SceneManager.round_number):
		0: mock_start(2, 1)
		1: mock_start(2, 1)
		2: mock_start(2, 1)
		_: assert(false)

func minigame_start():
	$Knife.position.x = knife_start_x
	
	for i in range(num_lines):
		var lineInstance = line.instantiate()
		get_tree().root.call_deferred("add_child", lineInstance)
		var magic_number = (rock_max_x - rock_start_x)/num_lines
		x_posn.append(randf_range(rock_start_x + (magic_number * i), rock_start_x + (magic_number * (i + 0.75))))
		lineInstance.position = Vector2(x_posn[i], 425)
		lineInstance.modulate.a = 0.8
		lineInstance.z_index = 0
		speed = level_speed
	game_started = true

func game_finished(score: int):
	SceneManager.round_number += 1
	SceneManager.minigame_stars_collected += score
	if (SceneManager.round_number < SceneManager.max_round):
		SceneManager.no_effect_change_scene("Main")
	else:
		SceneManager.no_effect_change_scene("interchoice")

func _process(_delta: float) -> void:
	if game_started:
		$Knife.position.x += speed
		if ($Knife.position.x > knife_max_x):
			$Knife.position.x = knife_start_x
			
		if (num_lines != correct_lines):
			#upper condition necessary so that correct_lines index is defined
			if ((x_posn[correct_lines] + 75) < $Knife.position.x):
				reset()
		else:
			speed = 0
			#await get_tree().create_timer(1).timeout #stackOverlow
			game_finished(1)
		
func reset():
	print("resetting")
	$Knife.position.x = knife_start_x
	correct_lines = 0

func _input(_delta):
	if Input.is_action_just_pressed("left_click") and not animating:
		if (abs(x_posn[correct_lines] - $Knife.position.x) < margin_error):
			correct_lines += 1
		else:
			reset()
			return
		
		animating = true  #ChatGPT # Prevent multiple clicks from triggering it again
		speed = 0  # Stop movement
		var anim = get_node_or_null("Knife/anim")
		anim.play("Cutting") #ChatGPT
		# Wait for animation to finish, then resume movement
		await 	anim.animation_finished #ChatGPT
		speed = level_speed 
		anim.play("default")  #ChatGPT
		animating = false  #ChatGPT
