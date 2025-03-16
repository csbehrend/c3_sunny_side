extends Control

<<<<<<< Updated upstream
func _ready() -> void:
	pass
=======
func _on_paren_tpaper_node_game_finished(score: int):
	SceneManager.round_number += 1
	SceneManager.minigame_stars_collected += score
	if (SceneManager.round_number < SceneManager.max_round):
		print("starting again")
		SceneManager.no_effect_change_scene("shapeColorSortScene")
	else:
		SceneManager.no_effect_change_scene("Main") # Cutting game

func mock_start(difficultyNumSlots):
	$PARENTpaperNode.start_game(difficultyNumSlots)
	
func _ready() -> void:
	print("again")
	match (SceneManager.round_number):
		0: mock_start(4)
		1: mock_start(7)
		2: mock_start(11)
		_: assert(false)
>>>>>>> Stashed changes
