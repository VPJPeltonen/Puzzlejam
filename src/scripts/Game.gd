extends Spatial

func _ready():
	$UI.hide()
	$LoseScreen.hide()

func start() -> void:
	$UI.show()

func game_over() -> void:
	Master.running = false
	$UI.hide()
	$LoseScreen.show()

func _on_RestartButton_pressed():
	get_parent().get_parent().restart()
