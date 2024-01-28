extends RigidBody2D

var cake = preload("res://Assets/Environment/Assets/Ammo/bullet_mc_2.png")
var fork = preload("res://Assets/Environment/Assets/Ammo/bullet_mc_3.png")
var knife = preload("res://Assets/Environment/Assets/Ammo/bullet_mc_1.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_Bullet_body_entered)
	var first_value = randi() % 3
	if first_value == 0:
		$Sprite2D.texture = fork   
	if first_value == 1:
		$Sprite2D.texture = cake 
	else:
		$Sprite2D.texture = knife 

func _on_Bullet_body_entered(body):
	# Check if the bullet has collided with a wall
	var g = body.get_groups()
	if(g[0] == "Tile"):
		queue_free()  # Remove the bullet from the scene upon collision with a wall):
