extends Spatial

func _ready():
	$CPUParticles.emitting = true
	$CPUParticles2.emitting = true
	
func _on_Timer_timeout():
	queue_free()
