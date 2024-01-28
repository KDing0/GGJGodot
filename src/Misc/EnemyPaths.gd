extends Node2D

signal every_enemy_dead

var signal_emitted = true

func reset():
	signal_emitted = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var no_enemies_alive = true
	for c in get_children():
		if c.get_child_count() > 0:
			no_enemies_alive = false
	
	if no_enemies_alive and !signal_emitted:
		every_enemy_dead.emit()
		signal_emitted = true
