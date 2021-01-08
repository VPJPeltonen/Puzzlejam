extends Control

export (Texture) var ironTex
export (Texture) var woodTex
export (Texture) var magicTex
export (Texture) var natureTex

var type: String = "none"

func set_type(newtype: String) -> void:
	type = newtype
	match type:
		"iron":
			change_tex(ironTex)
		"wood":
			change_tex(woodTex)
		"magic":
			change_tex(magicTex)
		"nature":
			change_tex(natureTex)

func change_tex(tex: Texture) -> void:
	$TextureButton.texture_normal = tex
	$TextureButton.texture_hover = tex
	$TextureButton.texture_pressed = tex
	$TextureButton.texture_focused = tex
	$TextureButton.texture_disabled = tex

func clear_pressed() -> void:
	$TextureButton.modulate = Color(0,1,0)
	$TextureButton.pressed = false

func _on_TextureButton_pressed():
	if $TextureButton.pressed:
		$TextureButton.modulate = Color(0.5,0.5,0.5)
		get_parent().button_clicked(self)
	else:
		$TextureButton.modulate = Color(1,1,1)
