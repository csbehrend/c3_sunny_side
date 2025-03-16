extends Control

const AllShapesList = ["yellow", "purple", "blue"]
const AllColorsList = ["square", "circle", "triangle"]

@onready var paperShapeAndColorList = []
@onready var slotsList = []
@onready var correctSlots = 0
@onready var numSlots = 0

@onready var currentPickedUpPaperTexture = null

@onready var personPaperSlot = preload("res://scenes/shapeColorSort/paperSlot.tscn")

signal game_finished

func _ready() -> void:
	randomize()
	#numSlots = randi_range(7, 11)
	
	$CenterSlotControl/paperSlotTexture.paperDropped.connect(onPaperDropped)
	$CenterSlotControl/paperSlotTexture.paperPickedUp.connect(onPaperPickedUp)
	$CenterSlotControl/paperSlotTexture.isCenterStack = true
	
	$CenterSlotControl.global_position = (get_parent().get_node("table").position + get_parent().get_node("table").size /2 + Vector2(-30, -30))
	
func start_game(stageNumSlots):
	numSlots = stageNumSlots
	generate_center_papers()
	instantiate_slots()
	nextCenterPaper()

func generate_center_papers():
	AllShapesList.size()
	AllColorsList.size()
	for i in range(0, numSlots):
		paperShapeAndColorList.append(AllShapesList.pick_random() + " " + AllColorsList.pick_random())
	
func instantiate_slots():
	var slotsProperties = paperShapeAndColorList.duplicate()
	slotsProperties.shuffle()
	var angle_step = 2 * PI / numSlots #math by ChatGPT
	
	for i in range(0, numSlots):
		var slotInstance = personPaperSlot.instantiate()
		var currentShapeAndColor = slotsProperties[i] 
		slotInstance.get_node("paperSlotTexture").paperDropped.connect(onPaperDropped)
		slotInstance.get_node("paperSlotTexture").paperPickedUp.connect(onPaperPickedUp)
		slotInstance.get_node("paperSlotTexture").shapeAndColor = currentShapeAndColor
		slotInstance.global_position = get_person_location(i)
		slotInstance.get_node("paperSlotTexture").rotation = (i * angle_step) + PI/2 #math by ChatGPT
		slotInstance.get_node("paperSlotTexture").texture = load("res://assets/shapeColorSort/chairs/" + currentShapeAndColor + " chair.png")
		#print(slotInstance.position, slotInstance.get_node("paperSlotTexture").shapeAndColor)
		get_tree().root.call_deferred("add_child", slotInstance)
		#slotInstance.get_node("paperSlotTexture").scale = Vector2(2, 2)
		slotsList.append(slotInstance)
		
func nextCenterPaper():
	$CenterSlotControl/paperSlotTexture.texture = load("res://assets/shapeColorSort/papers/" + paperShapeAndColorList[0] + " paper.png")
	$CenterSlotControl/paperSlotTexture.shapeAndColor = paperShapeAndColorList[0]

func onPaperDropped(correctStatus):
	currentPickedUpPaperTexture = null
	if (correctStatus == true):
		correctSlots += 1
		print("correct #", correctSlots)
		if (correctSlots == numSlots):
			minigame_over()
			return
		paperShapeAndColorList.pop_front()
	else:
		paperShapeAndColorList.append(paperShapeAndColorList.pop_front())
	nextCenterPaper()

func minigame_over():
	print("all done")

func onPaperPickedUp(node, paperTexture):
	currentPickedUpPaperTexture = paperTexture
	
#inspired by ChatGPT
func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		await get_tree().create_timer(0.25).timeout #stackOverlow
		#to ensure that this is always checked AFTER onPaperDropped

		if (currentPickedUpPaperTexture != null):
			#some item was picked up - not dropped but mouse was released
			#resetting the center paper texture
			$CenterSlotControl/paperSlotTexture.texture = currentPickedUpPaperTexture

#ChatGPT gemerated code
#calculates the location in polar coordinates and then converts it to cartesian coordinates
func get_person_location(i):
	var center = (get_parent().get_node("table").position + get_parent().get_node("table").size /2) + Vector2(16, 16)
	print(center)
	var radius = 430

	var angle_step = 2 * PI / numSlots
	var angle = i * angle_step
	var position = center + Vector2(radius * cos(angle), radius * sin(angle))
	return position
