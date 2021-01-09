extends Spatial

func _ready():
	$UI.hide()

func start() -> void:
	$UI.show()
