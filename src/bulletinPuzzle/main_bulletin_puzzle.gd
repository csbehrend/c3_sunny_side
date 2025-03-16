extends Node2D

func _on_puzzle_1_game_finished(score: int):
	SceneManager.round_score = score
	SceneManager.no_effect_change_scene("shapeColorSortScene")
	
func mock_start(difficultyPuzzleNumber):
	get_node("Puzzle" + str(difficultyPuzzleNumber)).start_game()
	
func _ready() -> void:
	mock_start(3)
