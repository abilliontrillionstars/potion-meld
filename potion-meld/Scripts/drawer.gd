extends TextureButton
var is_open: bool = false

var selected_slot: int = -1

func _on_pressed() -> void:
	if is_open:
		self.get_child(0).play_backwards("open")
	else:
		self.get_child(0).play("open")
	self.is_open = not self.is_open
	


func _on_ready() -> void:
	self.set_position(Vector2(892, 598))
