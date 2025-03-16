extends CharacterBody2D

var speed_multiplier = 0.75

func _physics_process(delta: float) -> void:
	var vel: Vector2 = get_global_mouse_position() - global_position
	velocity = vel * speed_multiplier
	move_and_slide()
