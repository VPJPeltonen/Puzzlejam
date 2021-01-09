extends MeshInstance

var health: int = 100

onready var UI = get_parent().get_node("UI")

func _on_Area_body_entered(body):
	if body.is_in_group("mob"):
		if body.side == "red":
			return
		health -= body.attack
		UI.AI_health_update(health)
		body.queue_free()
		if health <= 0:
			get_parent().victory()
