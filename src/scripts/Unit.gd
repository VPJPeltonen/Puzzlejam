extends KinematicBody

var target: Object
var speed: int = 200
var attack: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	move_and_slide(dir*speed*delta)