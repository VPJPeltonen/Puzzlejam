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

var mouse_follow: bool = false

func _process(delta):
	if mouse_follow:
		rect_position = Vector2(get_global_mouse_position().x-16,get_global_mouse_position().y-16)
		return
	#if moving:
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
	data.pos = target_pos
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
		#get_parent().button_clicked(self)
	else:
		$TextureButton.modulate = Color(1,1,1)

func _on_TextureButton_button_down():
	$TextureButton.modulate = Color(0.5,0.5,0.5)
	mouse_follow = true

func _on_TextureButton_button_up():
	mouse_follow = false
	$TextureButton.modulate = Color(1,1,1)
	var x_dif = target_pos.x - rect_position.x
	var y_dif = target_pos.y - rect_position.y
	if abs(x_dif) < abs(y_dif):
		if y_dif < 0:
			get_parent().tile_slide(self,"down")
		else:
			get_parent().tile_slide(self,"up")
	else:
		if x_dif < 0:
			get_parent().tile_slide(self,"right")
		else:
			get_parent().tile_slide(self,"left")
