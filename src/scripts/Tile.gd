extends Control

export (Texture) var ironTex
export (Texture) var woodTex
export (Texture) var magicTex
export (Texture) var natureTex

export (Texture) var peasantTex
export (Texture) var knightTex
export (Texture) var mageTex
export (Texture) var arrowTex
export (Texture) var heavyTex
export (Texture) var spearTex
export (Texture) var ramTex
export (Texture) var fireballTex
export (Texture) var woodwallTex

var type: String = "none"
var active_type: String = "none"
var x: int 
var y: int

var moving: bool = false
var target_pos: Vector2
var slide_speed: float = 5.0

func _process(delta):
	if moving:
		rect_position = rect_position.linear_interpolate(target_pos,slide_speed*delta)
		if rect_position == target_pos:
			moving = false

func set_type(newtype: String) -> void:
	$ColorRect.color = Color(0,0,0)
	type = newtype
	active_type = "none"
	match type:
		"iron":
			change_tex(ironTex)
		"wood":
			change_tex(woodTex)
		"magic":
			change_tex(magicTex)
		"nature":
			change_tex(natureTex)

func get_data() -> Dictionary:
	var data = {}
	data.x = x
	data.y = y
	data.pos = rect_position
	return data

func set_data(data: Dictionary) -> void:
	x = data.x
	y = data.y
	#rect_position = data.pos
	target_pos = data.pos
	moving = true

func change_tex(tex: Texture) -> void:
	$TextureButton.texture_normal = tex
	$TextureButton.texture_hover = tex
	$TextureButton.texture_pressed = tex
	$TextureButton.texture_focused = tex
	$TextureButton.texture_disabled = tex

func clear_pressed() -> void:
	$TextureButton.modulate = Color(1,1,1)
	$TextureButton.pressed = false

func highlight(type: String) -> void:
	$ColorRect.color = Color(1,1,1)
	active_type = type
	match type:
		"peasant":
			change_tex(peasantTex)
		"knight":
			change_tex(knightTex)
		"mage":
			change_tex(mageTex)
		"arrow":
			change_tex(arrowTex)
		"heavy":
			change_tex(heavyTex)
		"spear":
			change_tex(spearTex)
		"ram":
			change_tex(ramTex)
		"fireball":
			change_tex(fireballTex)
		"woodwall":
			change_tex(woodwallTex)
									
func _on_TextureButton_pressed():
	print("x:" + str(x) + " y:" + str(y) + " type:" + type)
	if $TextureButton.pressed:
		$TextureButton.modulate = Color(0.5,0.5,0.5)
		get_parent().button_clicked(self)
	else:
		$TextureButton.modulate = Color(1,1,1)
