extends Spatial

func _on_Button_pressed():
	$Game.start()
	$MainMenu.hide()	
	Master.running = true
