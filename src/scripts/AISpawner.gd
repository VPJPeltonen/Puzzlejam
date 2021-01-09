extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider

var spawn_time: int = 10

func _process(delta):
	if Master.running:
		if $Timer.is_stopped():
			$Timer.start(spawn_time)
	else:
		if !$Timer.is_stopped():
			$Timer.stop()		
		
func spawn() -> void:
	var new_enemy = peasant.instance()
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("Castle")
	new_enemy.set_side("red")

func _on_Timer_timeout():
	spawn()
