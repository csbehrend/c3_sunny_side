extends Node

@export var scene: String

func _ready():
	SceneManager.no_effect_change_scene("MainBulletinPuzzle")
