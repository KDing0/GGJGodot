extends Control

var MAX_LAUGHS = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$ProgressBar.value = LaughCounter.laugh / 5
	#if LaughCounter.laugh == 5:
