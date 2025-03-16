extends Control


func _on_paren_tpaper_node_game_finished(score: int):
	SceneManager.round_score = score
	SceneManager.no_effect_change_scene("typing_test")
