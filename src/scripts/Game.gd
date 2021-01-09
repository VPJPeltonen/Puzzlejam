extends Spatial

var level: int = 1

func _ready():
	$UI.hide()
	$LoseScreen.hide()
	$WinScreen.hide()

func set_level(new_level: int):
	level = new_level
	$UI.set_level(new_level)
	match new_level:
		1:
			$AISpawner.spawn_time = 8
			$AICastle.health = 80
		2:
			$AISpawner.spawn_time = 6
			$AICastle.health = 100
		3:
			$AISpawner.spawn_time = 5
			$AICastle.health = 110	
		4:
			$AISpawner.spawn_time = 4
			$AICastle.health = 120
		4:
			$AISpawner.spawn_time = 3
			$AICastle.health = 120			
		_:
			$AISpawner.spawn_time = 2
			$AICastle.health = 100+(new_level*5)
	$UI.update_AI_max_health($AICastle.health)

func start() -> void:
	$UI.show()

func victory() -> void:
	Master.running = false
	$UI.hide()
	$WinScreen.show()	

func game_over() -> void:
	Master.running = false
	$UI.hide()
	$LoseScreen.show()

func _on_RestartButton_pressed():
	get_parent().get_parent().restart()

func _on_ContinueButton_pressed():
	get_parent().get_parent().next_level(level)
