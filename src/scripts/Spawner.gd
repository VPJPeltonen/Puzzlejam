extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn() -> void:
	var new_enemy = peasant.instance()
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("AICastle")
	new_enemy.side = "blue"
