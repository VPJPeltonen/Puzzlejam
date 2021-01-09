extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider

var spawn_queue: Array = []

func _process(delta):
	if spawn_queue.empty():
		return
	if $Timer.is_stopped():
		$Timer.start()

func spawn_list(list: Array) -> void:
	for item in list:
		spawn_queue.append(item)
	#spawn_queue.append_array(list)

func spawn(type: String) -> void:
	var new_enemy
	match type:
		"peasant":
			new_enemy = peasant.instance()
		"knight":
			new_enemy = rider.instance()
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("AICastle")
	new_enemy.side = "blue"

func _on_Timer_timeout():
	if spawn_queue.empty():
		return
	spawn(spawn_queue.pop_front())
