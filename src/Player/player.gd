extends CharacterBody2D

##TODO add animation

const SPEED = 400.0


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertically = Input.get_axis("ui_up", "ui_down")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15)
		
	if vertically:
		velocity.y = vertically * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 15)
	
	move_and_slide()
	
