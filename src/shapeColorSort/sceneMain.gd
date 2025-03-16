extends Control

func _on_paren_tpaper_node_game_finished(score: int):
	SceneManager.round_number += 1
	SceneManager.minigame_stars_collected += score
	if (SceneManager.round_number < SceneManager.max_round):
		SceneManager.no_effect_change_scene("ShapeColourSortScene")
	else:
		SceneManager.no_effect_change_scene("Main") # Cutting game

func mock_start(difficultyNumSlots):
	$PARENTpaperNode.start_game(difficultyNumSlots)
	
func _ready() -> void:
	match (SceneManager.round_number):
		0: mock_start(2)
		1: mock_start(2)
		2: mock_start(9)
		_: assert(false)
