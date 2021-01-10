extends Spatial

export (PackedScene) var level

export (Texture) var zero
export (Texture) var one
export (Texture) var two
export (Texture) var three
export (Texture) var four
export (Texture) var five
export (Texture) var six
export (Texture) var seven
export (Texture) var eight
export (Texture) var nine

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
	if current_level < 10:
		$ContinueMenu/HBoxContainer/Digit1.texture = get_symbol(current_level)
		$ContinueMenu/HBoxContainer/Digit2.hide()
	elif current_level <= 20:
		$ContinueMenu/HBoxContainer/Digit2.show()
		var num = current_level-10
		$ContinueMenu/HBoxContainer/Digit1.texture = one
		$ContinueMenu/HBoxContainer/Digit2.texture = get_symbol(num)
	elif current_level <= 30:
		$ContinueMenu/HBoxContainer/Digit2.show()
		var num = current_level-20
		$ContinueMenu/HBoxContainer/Digit1.texture = one
		$ContinueMenu/HBoxContainer/Digit2.texture = get_symbol(num)
	elif current_level <= 40:
		$ContinueMenu/HBoxContainer/Digit2.show()
		var num = current_level-30
		$ContinueMenu/HBoxContainer/Digit1.texture = one
		$ContinueMenu/HBoxContainer/Digit2.texture = get_symbol(num)				
	#$ContinueMenu/Label.text = "Level " + str(current_level) 
	$ContinueMenu.show()	

func get_symbol(num: int) -> Texture:
	match num:
		0:
			return zero
		1:
			return one
		2:
			return two
		3:
			return three
		4:
			return four	
		5:
			return five	
		6:
			return six
		7:
			return seven	
		8:
			return eight	
		9:
			return nine	
		_:
			return zero

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
