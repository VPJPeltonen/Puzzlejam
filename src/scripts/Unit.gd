extends KinematicBody

var target: Object
var side: String
var projectile: bool = false
var wall: bool = false
var has_animations: bool = false
var dying: bool = false
export var speed: int = 100
export var attack: int = 10
export var health: int = 10

func _process(delta):
	if !Master.running:
		return
	if dying:
		return
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	look_at(target.global_transform.origin,Vector3.UP)
	move_and_slide(dir*(speed/2)*delta)

func damage(amount: int) -> void:
	if dying:
		return
	if has_animations:
		$blue/AnimationPlayer.play("hurt")
		$red/AnimationPlayer.play("hurt")
	health -= amount
	if health <= 0:
		$DeathTimer.start()
		dying = true

func set_side(new_side: String) -> void:
	side = new_side
	if side == "red":
		$blue.hide()
	else:
		$red.hide()

func _on_Area_body_entered(body):
	if dying:
		return
	if body.is_in_group("mob"):
		if body.side != side:
			body.damage(attack)
			if projectile:
				queue_free()

func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	if dying:
		return
	if area.get_parent().is_in_group("mob"):
		if area.get_parent().side != side:
			if has_animations:
				$blue/AnimationPlayer.play("attack")
				$red/AnimationPlayer.play("attack")
			area.get_parent().damage(attack)
			if projectile:
				queue_free()

func _on_DeathTimer_timeout():
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$blue/AnimationPlayer.play("walk")
		$red/AnimationPlayer.play("walk")		
