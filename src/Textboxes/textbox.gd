extends CanvasLayer

@onready var anims: AnimationPlayer = $AnimationPlayer

var textbox_open = true

func _ready():
	close_textbox()
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

func add_area_on(word) -> Area2D:
	var area = Area2D.new()
	var collision = CollisionShape2D.new()
	var colShape = RectangleShape2D.new()
	colShape.size = Vector2(50.0, 40.0)
	collision.shape = colShape
	area.add_child(collision)
	# create Area2D
	# Add CollisionShape
	return area
