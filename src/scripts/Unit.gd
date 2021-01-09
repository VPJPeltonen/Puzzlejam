extends KinematicBody

var target: Object
var side: String
var projectile: bool = false
var wall: bool = false
export var speed: int = 100
export var attack: int = 10
export var health: int = 10

func _process(delta):
	if !Master.running:
		return
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	look_at(target.global_transform.origin,Vector3.UP)
	move_and_slide(dir*speed*delta)

func damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()

func set_side(new_side: String) -> void:
	side = new_side
	if side == "red":
		$blue.hide()
	else:
		$red.hide()

func _on_Area_body_entered(body):
	if body.is_in_group("mob"):
		if body.side != side:
			body.damage(attack)
			if projectile:
				queue_free()

func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.get_parent().is_in_group("mob"):
		if area.get_parent().side != side:
			area.get_parent().damage(attack)
			if projectile:
				queue_free()
