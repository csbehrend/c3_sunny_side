#This entire script was AI generated. Very slightly edited for customizations like fonts
extends Node

var timers = {}
var active_timer: Timer = null
var time_left: float = 0
var timer_label: Label
var theme = load("res://assets/typing_content/typing_theme.tres")

func _ready():
	pass

func _process(delta):
	# Update the label with remaining time
	if active_timer and active_timer.time_left > 0:
		time_left = active_timer.time_left
		timer_label.text = str((snapped(time_left, 0.01)))
	else:
		if (timer_label != null):
			timer_label.text = "" # Breaks otherwise

func start_timer(scene_instance: Node, time_limit: float):
	print("[GlobalTimer] Request to start timer: %d seconds" % time_limit)

	# Stop and delete any previous timer
	if active_timer:
		print("[GlobalTimer] Deleting previous timer")
		active_timer.stop()
		active_timer.queue_free()
		active_timer = null

	# Create a new timer
	active_timer = Timer.new()
	active_timer.wait_time = time_limit
	active_timer.one_shot = true

	# Add to scene tree BEFORE starting
	add_child(active_timer)
	print("[GlobalTimer] New timer added with time: %d seconds" % time_limit)

	# Connect timeout to notify scene
	active_timer.timeout.connect(func():
		print("[GlobalTimer] Timer finished!")
		if scene_instance and scene_instance.is_inside_tree():
			print("[GlobalTimer] Notifying scene: Time's up!")
			scene_instance.call("on_time_up")  # Scene must have `on_time_up()`
	)

	active_timer.start()  # Start the timer
	print("[GlobalTimer] Timer started!")
	
	# Create a timer display label
	timer_label = Label.new()
	timer_label.text = "0"
	timer_label.set_position(Vector2(20, 20))  # Adjust position
	timer_label.theme = theme
	timer_label.add_theme_font_size_override("font_size", 40)  # Set font size to 40
	get_tree().root.call_deferred("add_child", timer_label)  # Add label to root scene safely
