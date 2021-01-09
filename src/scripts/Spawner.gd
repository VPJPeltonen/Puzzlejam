extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	pass # Replace with function body.
