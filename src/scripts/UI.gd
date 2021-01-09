extends Control

func set_level(new_level):
	$LevelLabel.text = "Level " + str(new_level)

func AI_health_update(amount: int) -> void:
	$AIHealth.value = amount

func health_update(amount: int) -> void:
	$PlayerHealth.value = amount

func update_AI_max_health(new_max: int) -> void:
	$AIHealth.max_value = new_max
	$AIHealth.value = new_max 
