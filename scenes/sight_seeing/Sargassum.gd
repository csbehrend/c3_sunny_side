extends Area2D

func _on_body_entered(body: Node2D) -> void:
	get_node("tickSprite").show()
	get_node("CollisionShape2D").call_deferred("set", "disabled", true)
