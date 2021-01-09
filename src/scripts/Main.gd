extends Spatial

export (PackedScene) var level

var current_level: int = 1

func _ready():
	$MainMenu.show()
	$ContinueMenu.hide()
	
func restart() -> void:
	var c = $GameHolder.get_children()
	for node in c:
		node.queue_free()
	var new_level = level.instance()
	$GameHolder.add_child(new_level)
	$MainMenu.show()
	
func next_level(passed_level: int) -> void:
	current_level += 1
	var c = $GameHolder.get_children()
	for node in c:
		node.queue_free()
	var new_level = level.instance()
	$GameHolder.add_child(new_level)
	$ContinueMenu/Label.text = "Level " + str(current_level) 
	$ContinueMenu.show()	
	
func _on_Button_pressed():
	var c = $GameHolder.get_children()
	c[0].start()
	c[0].set_level(current_level)
	$MainMenu.hide()	
	Master.running = true

func _on_NextLevelButton_pressed():
	var c = $GameHolder.get_children()
	c[0].start()
	c[0].set_level(current_level)
	$ContinueMenu.hide()	
	Master.running = true
