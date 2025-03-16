extends Control

#DeepSeek Function to change font color
func _ready():
	var rich_text_label_1 = $RichTextLabel#DeepSeek
	rich_text_label_1.clear()#DeepSeek
	rich_text_label_1.push_color(Color.BLACK)#DeepSeek
	rich_text_label_1.add_text("Credits")#DeepSeek
	
	var rich_text_label_2 = $RichTextLabel2#DeepSeek
	rich_text_label_2.clear()#DeepSeek
	rich_text_label_2.push_color(Color.BLACK)#DeepSeek
	rich_text_label_2.add_text("Exit")#DeepSeek
	
	var rich_text_label_3 = $RichTextLabel3#DeepSeek
	rich_text_label_3.clear()#DeepSeek
	rich_text_label_3.push_color(Color.BLACK)#DeepSeek
	rich_text_label_3.add_text("Play")#DeepSeek
	


func _on_button_pressed() -> void: #Coco Code Main Menu
	get_tree().quit()#Coco Code Main Menu

#Credits
func _on_button_2_pressed() -> void: #Coco Code Main Menu
	get_tree().change_scene_to_file("res://Menus/credits/GodotCredits.tscn")#Coco Code Main Menu

#Play
func _on_button_3_pressed() -> void: #Coco Code Main Menu
	get_tree().change_scene_to_file("res://Menus/into_scene.tscn")
