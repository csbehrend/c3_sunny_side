extends Node2D

@export_dir var base_dir: String

const options_file: String = "/options.txt"
const content_file: String = "/content.txt"


func _ready():
	SceneManager.game_state = SceneManager.GameState.STATE_PLAY_1
	match (SceneManager.game_state):
		SceneManager.GameState.STATE_PLAY_1:
			base_dir += "/1"
		SceneManager.GameState.STATE_PLAY_2:
			base_dir += "/2"
		SceneManager.GameState.STATE_PLAY_3:
			base_dir += "/3"
		SceneManager.GameState.STATE_PLAY_4:
			base_dir += "/4"
		_:
			assert(false)
	
	var file = FileAccess.open(base_dir + options_file, FileAccess.READ)
	var options: String = file.get_as_text()
	file.close()
	
	file = FileAccess.open(base_dir + content_file, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	
	options.split()
	
	var options_arr: Array[String]
	var content_arr: Array[String]
	
	options_arr.assign(options.split("\n", false))
	content_arr.assign(content.split("\n", false))
	
	print(options_arr)
	print(content_arr)
