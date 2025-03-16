extends Node2D

func _process(_delta: float) -> void:
	var anim = get_node_or_null("AnimatedSprite2D")
	anim.play("default")
	var rich_text_label = $RichTextLabel#DeepSeek
	rich_text_label.clear()#DeepSeek
	rich_text_label.push_color(Color.BLACK)#DeepSeek
	rich_text_label.add_text("Sargassum Rush!")#DeepSeek
