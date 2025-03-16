extends Control

func _on_monkey_type_test_completed(score: int):
	SceneManager.round_score = score
	SceneManager.no_effect_change_scene("top_level")
