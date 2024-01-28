extends Area2D

var from_word = ""
var to_word = ""

signal hit(from, to)

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	print("Area hit by: ", body)
	hit.emit(from_word, to_word)
	body.queue_free()
	self.queue_free()
