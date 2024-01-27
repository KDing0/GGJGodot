extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_Bullet_body_entered)   

func _on_Bullet_body_entered(body):
	var collisionLayer = body.get_collision_layer()
	if collisionLayer == 1:
		queue_free()

