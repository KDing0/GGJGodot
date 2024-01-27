extends CharacterBody2D

func _on_ready():
	Spawning.player = self

##TODO add animation

const SPEED = 400.0
var BULLETSPEED = 1000  # Adjust this value to control the bullet speed
var FIRERATE = 0.2

var bullet_scene = preload("res://Bullets/Bullet.tscn")
var can_fire = true

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
	
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()         
		
	
func shoot():
	var bullet_instance = bullet_scene.instantiate() #bullet_scene.instance()
	bullet_instance.position = global_position
	bullet_instance.gravity_scale = 0
	bullet_instance.linear_velocity = Vector2(0, -BULLETSPEED)
	get_parent().add_child(bullet_instance)
	can_fire = false
	await get_tree().create_timer(FIRERATE).timeout
	can_fire = true
	
func hit_by_bullet():
	print("OUCH")
	return
