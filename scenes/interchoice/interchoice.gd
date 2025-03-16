extends Node2D

@export_dir var base_dir: String

const options_file: String = "/options.txt"
const content_file: String = "/content.txt"

var options_arr: Array[String]
var content_arr: Array[String]

func _ready():
	#SceneManager.game_state = SceneManager.GameState.STATE_PLAY_1
	match (SceneManager.game_state):
		SceneManager.GameState.STATE_PLAY_1:
			base_dir += "/1"
			SceneManager.game_state = SceneManager.GameState.STATE_PLAY_2
		SceneManager.GameState.STATE_PLAY_2:
			base_dir += "/2"
			SceneManager.game_state = SceneManager.GameState.STATE_PLAY_3
		SceneManager.GameState.STATE_PLAY_3:
			base_dir += "/3"
			SceneManager.game_state = SceneManager.GameState.STATE_PLAY_4
		SceneManager.GameState.STATE_PLAY_4:
			base_dir += "/4"
			SceneManager.game_state = SceneManager.GameState.STATE_PLAY_5
		_:
			assert(false)
	
	var file = FileAccess.open(base_dir + options_file, FileAccess.READ)
	var options: String = file.get_as_text()
	file.close()
	
	file = FileAccess.open(base_dir + content_file, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	
	options.split()
	
	options_arr.assign(options.split("\n", false))
	content_arr.assign(content.split("\n", false))
	
	print(options_arr)
	print(content_arr)
	
	var background_texture = get_child(0)
	
	background_texture.get_child(0).text = options_arr[0]
	
	var score: int = SceneManager.minigame_stars_collected
	score = 4
	$TextureRect/Choice1/RichTextLabel.text = options_arr[1]
	
	if (score >= 1):
		$TextureRect/Choice2/RichTextLabel.text = options_arr[2]
	else:
		$TextureRect/Choice2.texture_normal = load("res://assets/interchoice/box_star_1.png")
		$TextureRect/Choice2.disabled = true
		$TextureRect/Choice2/RichTextLabel.visible = false

	if (score >= 2):
		$TextureRect/Choice3/RichTextLabel.text = options_arr[3]
	else:
		$TextureRect/Choice3.texture_normal = load("res://assets/interchoice/box_star_2.png")
		$TextureRect/Choice3/RichTextLabel.visible = false

	if (score >= 3):
		$TextureRect/Choice4/RichTextLabel.text = options_arr[4]
	else:
		$TextureRect/Choice4.texture_normal = load("res://assets/interchoice/box_star_3.png")
		$TextureRect/Choice4/RichTextLabel.visible = false


func _on_choice_1_pressed():
	print("Pressed 1")
	common_end(0)

func _on_choice_2_pressed():
	print("Pressed 2")
	common_end(1)

func _on_choice_3_pressed():
	print("Pressed 3")
	common_end(2)

func _on_choice_4_pressed():
	print("Pressed 4")
	common_end(3)

func common_end(idx: int):
	SceneManager.typing_content += content_arr[idx]
	SceneManager.prep_next_game_vars()
	match (SceneManager.game_state):
		SceneManager.GameState.STATE_PLAY_2:
			SceneManager.typing_content += " "
			SceneManager.no_effect_change_scene("MainBulletinPuzzle")
		SceneManager.GameState.STATE_PLAY_3:
			SceneManager.typing_content += " "
			SceneManager.no_effect_change_scene("shapeColorSortScene")
		SceneManager.GameState.STATE_PLAY_4:
			SceneManager.typing_content += " "
			SceneManager.no_effect_change_scene("Main") # cutting
		SceneManager.GameState.STATE_PLAY_5:
			SceneManager.no_effect_change_scene("Main_Menu")
			#SceneManager.no_effect_change_scene("typing_test")
		_:
			assert(false)
