extends Node2D

@export var cam: Camera2D
@export var textbox: CanvasLayer

func _ready():
	self.add_child(textbox.add_area_on("Bla"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = Vector2.ZERO - cam.position
