extends Node2D

func _process(_delta: float) -> void:
	var anim = get_node_or_null("Background/anim")
	anim.play("default")
	#$Telescope/Node2D/Telescope.position = get_global_mouse_position()
func  _ready():
	var area2d = $"Sargassum/Area2D"
	area2d.body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D):
	if body.name == "CharacterBody2D":
		$"Sargassum".visible = false
		print("hit")
	
