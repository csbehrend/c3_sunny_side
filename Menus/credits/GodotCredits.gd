extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.BLUE_VIOLET

# var scroll_speed := base_speed
var speed_up := false

@onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A Sunny Side Studios Game"
	],[
		"Programming",
		"Connor Behrend",
		"Amey Bhandari",
		"Brandon Farber"
	],[
		"Art",
		"Ayusha Patra",
		"Petra Schwaab"
	],[
		"Music",
		"Petra Schwaab"
	],[
		"Sound Effects",
		"Petra Schwaab"
	],[
		"Writing",
		"Petra Schwaab"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Art created with PixilArt",
		"https://pixilart.com",
		"",
		"Creative Commons SFX",
		"keyboard2.wav by samchitto -- https://freesound.org/s/696040/ -- License: Creative Commons 0 ",
		"KnifeCuts.wav by svlargacha -- https://freesound.org/s/567976/ -- License: Creative Commons 0 ",
		"Paper Rustling 02.wav by swidmark -- https://freesound.org/s/171325/ -- License: Creative Commons 0 ",
		"BG SaSc Turkey Slow Ocean Waves Far Low.wav by Profispiesser -- https://freesound.org/s/583062/ -- License: Creative Commons 0 ",
		"Pacifica Ocean Waves with Birds by el_boss -- https://freesound.org/s/561502/ -- License: Creative Commons 0 ",
		"Public Pixel Font designed by GGBotNet. This Font Software is licensed under the Creative Commons Zero v1.0 Universal.",
		"",
		"MIT License",
		"Copyright (c) 2019 Ben Bishop",
		"godot-credits"
		
	],[
		"Special thanks",
		"C3!"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.position.y -= scroll_speed
			if l.position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# This is called when the credits finish and returns to the main menu
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		# new_line.add_color_override("font_color", title_color)
		new_line.set("theme_override_colors/font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
