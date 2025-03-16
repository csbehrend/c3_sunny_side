extends Node2D

var sargassumNode = load("res://scenes/sight_seeing/sargassum.tscn")

var sargassumTextures = [
	load("res://assets/sight_seeing/Sargassum patch 1.png"),
load("res://assets/sight_seeing/Sargassum patch 2.png"),
load("res://assets/sight_seeing/Sargassum patch 3.png"),
load("res://assets/sight_seeing/Sargassum patch 4.png")
]

var numAlgae
var correctAlgae = 0

func _process(_delta: float) -> void:
	var anim = get_node_or_null("Background/anim")
	anim.play("default")
	#$Telescope/Node2D/Telescope.position = get_global_mouse_position()

func  _ready():
	randomize()
	mock_start(15, 2)

func mock_start(difficultyNumAlgae,difficultySpeedMultiplier):
	numAlgae = difficultyNumAlgae
	$Container.z_index = 2
	$Container.get_node("CharacterBody2D").speed_multiplier = difficultySpeedMultiplier
	
	for i in range(numAlgae):
		var sargInstance = sargassumNode.instantiate()
		
		sargInstance.position = Vector2(randi_range(-750, 1000), randi_range(500, 1000))
		var scaleRandom = randf_range(0.35, 0.45)
		sargInstance.scale = Vector2(scaleRandom, scaleRandom)
		sargInstance.get_node("Area2D").get_node("Sprite2D").texture = sargassumTextures.pick_random()
		
		var area2d = sargInstance.get_node("Area2D")
		area2d.body_entered.connect(_on_body_entered)
		
		sargInstance.z_index = 0
		get_tree().root.call_deferred("add_child", sargInstance)

func _on_body_entered(body: Node2D):
	if body.name == "CharacterBody2D":
		#var global_position = $"Sargassum/Area2D/Sprite2D".global_position
		#Something to have the location set back to where the sargassum was originally located because it moves for some reason
		#$"Sargassum/Area2D/Sprite2D".global_position = global_position 
		#print("hit")
		correctAlgae += 1
		if (correctAlgae == numAlgae):
			$Container.hide()
	
