extends Position3D

export(PackedScene) var peasant

func _ready():
	pass # Replace with function body.

func spawn() -> void:
	var new_enemy = peasant.instance()
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("Castle")
	new_enemy.side = "red"

func _on_Timer_timeout():
	spawn()
