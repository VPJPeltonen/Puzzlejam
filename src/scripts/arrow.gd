extends CPUParticles


onready var blue1 = get_parent().get_node("blue/arrow_1")
onready var blue2 = get_parent().get_node("blue/arrow_2")

onready var red1 = get_parent().get_node("red/arrow_3")
onready var red2 =  get_parent().get_node("red/arrow_4")

var first: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	first = !first
	if first:
		blue1.show()
		blue2.hide()
		red1.show()
		red2.hide()
	else:
		blue1.hide()
		blue2.show()
		red1.hide()
		red2.show()
