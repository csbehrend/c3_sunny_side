extends Node2D

@onready var scene1 = $Scene1

@onready var label1 = $Scene1_Text#DeepSeek
@onready var label2 = $Scene1_Text2#DeepSeek
@onready var label3 = $Scene1_Text3#DeepSeek

var scene_count = 0

func _ready() -> void:
	label1.visible = false
	label2.visible = false
	label3.visible = false
	
	label1.clear()#DeepSeek
	label1.push_color(Color.BLACK)#DeepSeek
	label1.add_text("Thanks for helping with our environmental response policy cycle! So long as the sargassum keeps coming in, we’ll have to keep adapting and working to bring our community through this problem.")#DeepSeek
	label1.visible = true

	label2.clear()#DeepSeek
	label2.push_color(Color.BLACK)#DeepSeek
	label2.add_text("Just like here, you can be a positive force in your own area! While your community may not have the same problems as mine, chances are there’s some environmental issue close to home.")#DeepSeek

	label3.clear()#DeepSeek
	label3.push_color(Color.BLACK)#DeepSeek
	label3.add_text("Your local knowledge and effort can be a valuable part of your local policy cycle. You can be a part of the solution, helping with a beach cleanup, speaking at a town hall, or doing anything in between. So, get out there and use what you know!")#DeepSeek

func _input(_delta):
	if Input.is_action_just_pressed("left_click"):
		scene_count += 1
	
	if scene_count == 1:
		label1.visible = false
		label2.visible = true
	elif scene_count == 2:
		label2.visible = false
		label3.visible = true
