extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_level(new_level):
	$LevelLabel.text = "Level " + str(new_level)

func AI_health_update(amount: int) -> void:
	$AIHealth.value = amount

func health_update(amount: int) -> void:
	$PlayerHealth.value = amount

func update_AI_max_health(new_max: int) -> void:
	$AIHealth.max_value = new_max
	$AIHealth.value = new_max 
