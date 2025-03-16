extends Node2D

func _ready() -> void:
	mock_start(SceneManager.round_number + 1)

func _on_puzzle_1_game_finished(score: int):
	finish_func(score)
	
func _on_puzzle_2_game_finished(score: int):
	finish_func(score)

func _on_puzzle_3_game_finished(score: int):
	finish_func(score)

func finish_func(score: int):
	SceneManager.round_number += 1
	if (SceneManager.round_number < SceneManager.max_round):
		SceneManager.no_effect_change_scene("MainBulletinPuzzle")
	else:
		SceneManager.no_effect_change_scene("interchoice")

func hide_puzzle(difficultyPuzzleNumber):
	get_node("Puzzle" + str(difficultyPuzzleNumber)).visible = false

func mock_start(difficultyPuzzleNumber):
	get_node("Puzzle" + str(difficultyPuzzleNumber)).start_game()
