extends Position3D

export(PackedScene) var peasant
export(PackedScene) var rider
export(PackedScene) var mage
export(PackedScene) var arrow
export(PackedScene) var heavy
export(PackedScene) var spear
export(PackedScene) var ram
export(PackedScene) var fireball
export(PackedScene) var woodwall

var rng = RandomNumberGenerator.new()

var spawn_time: int = 10

func _ready():
	rng.randomize()

func _process(delta):
	if Master.running:
		if $Timer.is_stopped():
			$Timer.start(spawn_time)
	else:
		if !$Timer.is_stopped():
			$Timer.stop()		
		
func spawn() -> void:
	var num = rng.randi_range(0,18)
	var new_enemy
	match num:
		0,1:
			new_enemy = arrow.instance()
		4,5:
			new_enemy = rider.instance()
		5:
			new_enemy = mage.instance()
		7:
			new_enemy = heavy.instance()
		9,10:
			new_enemy = spear.instance()
		11:
			new_enemy = ram.instance()
		13,14:
			new_enemy = fireball.instance()
		15:
			new_enemy = woodwall.instance()
		_:
			new_enemy = peasant.instance()
	add_child(new_enemy)
	new_enemy.target = get_parent().get_node("Castle")
	new_enemy.set_side("red")

func _on_Timer_timeout():
	spawn()
