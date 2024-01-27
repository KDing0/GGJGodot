extends CharacterBody2D

func _on_ready():
	Spawning.player = self

##TODO add animation

const SPEED = 400.0
var BULLETSPEED = 1000  # Adjust this value to control the bullet speed
var FIRERATE = 0.2
@onready var sprite = $AnimatedSprite2D

var bullet_scene = preload("res://Bullets/Bullet.tscn")
var can_fire = true

func _physics_process(delta):
	move()
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()   
		
func move():
	if (velocity.x > 1 || velocity.x < -1 || velocity.y > 1 || velocity.y < -1):
		sprite.animation = "running"
	else:
		sprite.animation = "default"
	# TODO should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("player_left", "player_right")
	var vertically = Input.get_axis("player_up", "player_down")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15)
		
	if vertically:
		velocity.y = vertically * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 15)
		
	var isLeft = velocity.x < 0
	sprite.flip_h = isLeft
	
func shoot():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.position = global_position
	
	var mousePosition = get_global_mouse_position()
	var mouseX = mousePosition.x
	var mouseY = mousePosition.y
	var distX = mouseX - bullet_instance.position.x
	var distY = mouseY - bullet_instance.position.y 
	var xDirection = distX/(abs(distX)+abs(distY))
	var yDirection = distY/(abs(distX)+abs(distY))
	
	bullet_instance.gravity_scale = 0
	bullet_instance.linear_velocity.x = xDirection * BULLETSPEED
	bullet_instance.linear_velocity.y = yDirection * BULLETSPEED
	get_parent().add_child(bullet_instance)
	
	can_fire = false
	await get_tree().create_timer(FIRERATE).timeout
	can_fire = true
	
func hit_by_bullet():
	print("OUCH")
	Livecounter.lives = Livecounter.lives - 1
