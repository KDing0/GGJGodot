extends CharacterBody2D

@export var SPEED = 200.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var movement_target_position: Vector2:
	set(value):
		movement_target_position = value
		nav_agent.target_position = value


func _ready():
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	movement_target_position = Vector2(0.0, 0.0)
	
	var timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout)
	self.add_child(timer)
	timer.start(2.0)

func _on_timer_timeout():
	movement_target_position = Vector2(1000.0, 1000.0)
	

func _physics_process(delta):
	
	if nav_agent.is_navigation_finished():
		return
	
	var current_agent_pos: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	
	velocity = current_agent_pos.direction_to(next_path_position) * SPEED
	move_and_slide()
