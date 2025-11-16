extends TextureButton
var is_open: bool = false

var selected_slot: int = -1

func _on_pressed() -> void:
	if is_open:
		$"../../../SoundManager/DrawerOpen".play()
		self.get_child(0).play_backwards("open")
	else:
		$"../../../SoundManager/DrawerClose".play()
		self.get_child(0).play("open")
	self.is_open = not self.is_open
	
func open_drawer():
	if !is_open:
		$"../../../SoundManager/DrawerOpen".play()
		self.get_child(0).play("open")
		self.is_open = true

func _on_ready() -> void:
	self.set_position(Vector2(768, 539))
