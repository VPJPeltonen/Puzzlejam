extends MeshInstance

var health: int = 100

var side: String = "red" 

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


func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.get_parent().is_in_group("mob"):
		if area.get_parent().side == "red":
			return
		health -= area.get_parent().attack
		UI.AI_health_update(health)
		area.get_parent().queue_free()
		if health <= 0:
			get_parent().victory()

