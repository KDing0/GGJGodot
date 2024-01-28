extends CanvasLayer

@onready var anims: AnimationPlayer = $AnimationPlayer

var area_script = load("res://Textboxes/textbox_areas.gd")
var textbox_open = true

func _ready():
	#open_textbox()
	$Control.offset_bottom = 0.0
	$Control.offset_left = 0.0
	$Control.offset_right = 0.0
	$Control.offset_top = 0.0
	pass

func open_textbox():
	if !textbox_open:
		anims.play("open_textbox")
		textbox_open = true

func close_textbox():
	if textbox_open:
		anims.play("close_textbox")
		textbox_open = false

func setText(text):
	pass

func changeText(from_word, to_word):
	var label: RichTextLabel = $Control/TextBoxContainer/BoxMargin/TextMargin/RichTextLabel
	label.text = label.text.replace("[b]" + from_word + "[/b]", to_word)

func add_area_on(word) -> Area2D:
	
	var label: RichTextLabel = $Control/TextBoxContainer/BoxMargin/TextMargin/RichTextLabel
	var fnt = label.get_theme_font("normal_font")
	var fnt_size = label.get_theme_font_size("normal_font_size")
	
	# get position of word in text
	var text = label.text
	var text_lines = text.split("\n")
	var idx = text.find(word)
	var lines = text.count("\n")
	var line = text.count("\n", 0, idx) if idx != 0 else 0
	var idx_in_line = text_lines[line].find(word)
	print(word, ", ", lines, ", ", line)
	var length_to_word = fnt.get_string_size(text_lines[line].substr(0, idx_in_line), 0, -1, fnt_size) / 2.0
	var height_to_word = fnt.get_height(fnt_size) * line / 2.0
	var length_of_word = fnt.get_string_size(word, 0, -1, fnt_size) / 2.0
	
	var posX = -320 + (length_of_word.x / 2.0) + length_to_word.x + $Control/ImageContainer.size.x / 2.0 + 30.0
	var posY = 180 - (length_of_word.y / 2.0) - ((lines - line) * length_of_word.y) - 12
	
	var area = Area2D.new()
	var collision = CollisionShape2D.new()
	var colShape = RectangleShape2D.new()
	colShape.size = length_of_word
	collision.shape = colShape
	area.add_child(collision)
	area.monitorable = true
	area.position = Vector2(posX, posY)
	area.collision_layer = 1
	area.collision_mask = 16
	area.set_script(area_script)
	area.from_word = word
	area.to_word = "hi hi"
	
	label.text = label.text.replace(word, "[b]" + word + "[/b]")
	
	return area
