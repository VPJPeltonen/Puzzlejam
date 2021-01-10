extends Control

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

func set_level(new_level):
	#$LevelLabel.text = "Level " + str(new_level)
	if new_level < 10:
		$HBoxContainer/Digit1.texture = get_symbol(new_level)
		$HBoxContainer/Digit2.hide()
	elif new_level <= 20:
		$HBoxContainer/Digit2.show()
		var num = new_level-10
		$HBoxContainer/Digit1.texture = one
		$HBoxContainer/Digit2.texture = get_symbol(num)
	elif new_level <= 30:
		$HBoxContainer/Digit2.show()
		var num = new_level-20
		$HBoxContainer/Digit1.texture = one
		$HBoxContainer/Digit2.texture = get_symbol(num)
	elif new_level <= 40:
		$HBoxContainer/Digit2.show()
		var num = new_level-30
		$HBoxContainer/Digit1.texture = one
		$HBoxContainer/Digit2.texture = get_symbol(num)	


func AI_health_update(amount: int) -> void:
	$AIHealth.value = amount

func health_update(amount: int) -> void:
	$PlayerHealth.value = amount

func update_AI_max_health(new_max: int) -> void:
	$AIHealth.max_value = new_max
	$AIHealth.value = new_max 

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
