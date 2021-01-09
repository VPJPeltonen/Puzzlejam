extends KinematicBody

var target: Object
var side: String
var projectile: bool = false
export var speed: int = 100
export var attack: int = 10
export var health: int = 10

func _process(delta):
	if !Master.running:
		return
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	move_and_slide(dir*speed*delta)

func damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("mob"):
		if body.side != side:
			body.damage(attack)
			if projectile:
				queue_free()
