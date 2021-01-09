extends MeshInstance

var health: int = 100

onready var UI = get_parent().get_node("UI")

var side: String = "blue" 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("mob"):
		if body.side == "blue":
			return
		health -= body.attack
		UI.health_update(health)
		body.queue_free()
		if health <= 0:
			get_parent().game_over()


func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.get_parent().is_in_group("mob"):
		if area.get_parent().side == "blue":
			return
		health -= area.get_parent().attack
		UI.health_update(health)
		area.get_parent().queue_free()
		if health <= 0:
			get_parent().game_over()

