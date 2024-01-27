extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_Bullet_body_entered)   

func _on_Bullet_body_entered(body):
	# Check if the bullet has collided with a wall
	var collisionLayer = body.get_collision_layer()
	print(collisionLayer)
	if collisionLayer == 1:
		queue_free()  # Remove the bullet from the scene upon collision with a wall):
