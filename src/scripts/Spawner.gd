extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider
export(PackedScene) var mage
export(PackedScene) var arrow
export(PackedScene) var heavy
export(PackedScene) var spear
export(PackedScene) var ram
export(PackedScene) var fireball

var spawn_queue: Array = []

func _process(delta):
	if spawn_queue.empty() or !Master.running:
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
		"heavy":
			new_enemy = heavy.instance()
		"mage":
			new_enemy = mage.instance()
		"spear":
			new_enemy = spear.instance()
		"ram":
			new_enemy = ram.instance()
		"arrow":
			new_enemy = arrow.instance()
			new_enemy.projectile = true
		"fireball":
			new_enemy = fireball.instance()
			new_enemy.projectile = true
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("AICastle")
	new_enemy.side = "blue"

func _on_Timer_timeout():
	if spawn_queue.empty():
		return
	spawn(spawn_queue.pop_front())
