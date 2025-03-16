extends Control

func _on_paren_tpaper_node_game_finished(score: int):
	SceneManager.round_score = score
	SceneManager.no_effect_change_scene("typing_test")
	
func mock_start(difficultyNumSlots):
	$PARENTpaperNode.start_game(difficultyNumSlots)
	
func _ready() -> void:
	mock_start(9)
