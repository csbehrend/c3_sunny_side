extends FlowContainer

@export_file("*.txt") var text_path: String = ""
@export var word_scene: PackedScene

var word_objs: Array = []
var eval: bool = false

func init_words(line_width: int):
	var char_width: int  = get_theme_font("font").get_string_size("a", HORIZONTAL_ALIGNMENT_LEFT, -1, get_theme_font_size("font_size")).x
	var max_char: int =  line_width / char_width
	print(char_width, " ", max_char)
	
	var content: String = ""
	if text_path != "":
		var file = FileAccess.open(text_path, FileAccess.READ)
		content = file.get_as_text()
		file.close()
		print(content)
		
	var words: Array[String]
	words.assign(content.split(" "))
	
	for idx in range(words.size() - 1):
		words[idx] += " "
	words[words.size() - 1] = words[words.size() - 1].get_slice("\n", 0)
	
	print(words)
	#var i: int = 0
	for word in words:
		assert(word.length() <= max_char)
		word_objs.append(add_word(word))
	
	eval = true

func add_word(content: String):
	var inst = word_scene.instantiate()
	inst.write_word(content)
	add_child(inst)
	return inst
