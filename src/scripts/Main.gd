extends Spatial

export (PackedScene) var level

func _ready():
	$MainMenu.show()

func restart() -> void:
	var c = $GameHolder.get_children()
	for node in c:
		node.queue_free()
	var	new_level = level.instance()
	$GameHolder.add_child(new_level)
	$MainMenu.show()
	
func _on_Button_pressed():
	var c = $GameHolder.get_children()
	c[0].start()
	$MainMenu.hide()	
	Master.running = true
