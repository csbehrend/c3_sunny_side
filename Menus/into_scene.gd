extends Node2D

@onready var scene1 = $Scene1
@onready var scene2 = $Scene2
@onready var scene3 = $Scene3


@onready var label1 = $Scene1_Text#DeepSeek
@onready var label2 = $Scene1_Text2#DeepSeek
@onready var label3 = $Scene2_Text#DeepSeek
@onready var label4 = $Scene2_Text2#DeepSeek
@onready var label5 = $Scene3_Text#DeepSeek


var scene_count = 0
func _ready() -> void:

	
	scene1.visible = false
	scene2.visible = false
	scene3.visible = false
		
	label1.visible = false
	label2.visible = false
	label3.visible = false
	label4.visible = false
	label5.visible = false
	
	label1.clear()#DeepSeek
	label1.push_color(Color.BLACK)#DeepSeek
	label1.add_text("Hey there! You’re looking at a map of the Caribbean Sea and the many island countries that surround it. Lots of people know this region for beautiful beaches, but unfortunately our shores are being invaded right now. Invaded... by seaweed!")#DeepSeek
	label1.visible = true
	scene1.visible = true

	label2.clear()#DeepSeek
	label2.push_color(Color.BLACK)#DeepSeek
	label2.add_text("Since 2011, massive influxes of sargassum seaweed have been filling the Sea and washing ashore. These mats of brown algae used to be a normal part of our ecosystem, but the quantities have gotten so big that a lot of islands have called national emergencies!")#DeepSeek

	label3.clear()#DeepSeek
	label3.push_color(Color.BLACK)#DeepSeek
	label3.add_text("Communities like mine in Barbados are working to adapt despite the hazards, but a lot of our understanding or local knowledge isn’t yet being used at the government level. Fisherfolk and other locals could have a lot of valuable input on new policies!")#DeepSeek

	label4.clear()#DeepSeek
	label4.push_color(Color.BLACK)#DeepSeek
	label4.add_text("Barbados")#DeepSeek

	label5.clear()#DeepSeek
	label5.push_color(Color.BLACK)#DeepSeek
	label5.add_text("Some researchers at the University of the West Indies campus on Barbados came up with a five-step cycle for new environmental policies with lots of ideas for how locals can get involved. Time for you to try it out!")#DeepSeek


func _input(_delta):
	
	if Input.is_action_just_pressed("left_click"):
		scene_count += 1
	
	if scene_count == 1:
		label1.visible = false
		label2.visible = true

	elif scene_count == 2:
		label2.visible = false
		scene2.visible = false
		scene2.visible = true
		label3.visible = true
		label4.visible = true
	elif scene_count == 3:
		scene2.visible = false
		label3.visible = false
		label4.visible = false
		scene3.visible = true
		var anim = get_node_or_null("Scene3")
		anim.play("default") #ChatGPT
		# Wait for animation to finish, then resume movement
		await 	anim.animation_finished #ChatGPT
		var animation_finished = 1
		if animation_finished == 1:
			label5.visible = true
		
