extends Node2D

var animating = false #ChatGPT
var max_x = 500
var count = 1 #ChatGPT
var speed = 1 #Determines if the knife moves horizontally or not

var rng = RandomNumberGenerator.new()
var line = load("res://scenes/Cutting/lines.tscn")
var x_pos= []
var line_inst = []
var y = 50
var x = 0

#Contains the ranges used for randi_range to randomly generate an x posiition for a line
var ranges = [[30, 160], [170, 336], [350, 500]] #ChatGPT
#Single range value from ranges
var range_single = []
var range_count = 0

func _ready() -> void:
	$Knife.position.x = 0
	for i in range(9):
		range_single = ranges[range_count]
		print(range_single[0], range_single[1])
		var my_random_number = rng.randf_range(range_single[0], range_single[1])
		#Generate a random x value from a certain range, which updates each time a new
		#for loop iteration runs, making sure lines aren't too close to each other
		#x = randi_range(range_single[0], range_single[1])
		x_pos.append(x)
		print(x)
		
		#Create new line, assign x value, append to list
		#var new_line = line.instantiate()
		#self.add_child(new_line) #ChatGPT
		
		#line_inst.append(new_line)
		#count += 1
		#if (i % 3 == 0):
			#range_count = (range_count + 1) % len(ranges)
		
		#if len(line_inst) == 9:
	set_process(true)
			
		
	
func _process(_delta: float) -> void:
	if count < 4: #ChatGPT
		#print($Knife.position.x)
#		print(line_inst[0])
		#for i in range (1 * count, 3 * count):
			#line_inst[i-1].position = Vector2(x_pos[i-1],y)
		if speed == 1:
			$Knife.position.x += 0.5 * count
			if ($Knife.position.x >= max_x):
				$Knife.position.x = 0
				count += 1


func _input(_delta):
	if Input.is_action_just_pressed("left_click") and not animating:
		animating = true  #ChatGPT # Prevent multiple clicks from triggering it again
		speed = 0  # Stop movement
		var anim = get_node_or_null("Knife/anim")
		anim.play("Cutting") #ChatGPT
		# Wait for animation to finish, then resume movement
		await 	anim.animation_finished #ChatGPT
		speed = 1 
		anim.play("default")  #ChatGPT
		animating = false  #ChatGPT
