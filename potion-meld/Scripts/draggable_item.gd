extends TextureButton

var current_slot: Control
@onready var inv = $"/root/World/HUD/InventoryManager/InventoryPopout"
@onready var inv_manager = $"/root/World/HUD/InventoryManager"

@export var ingredient_type: Ingredient.ingredient_type

func _process(delta: float) -> void:
	var dest: Vector2
	# mouse dragging
	if self.button_pressed:
		dest = get_viewport().get_mouse_position()
	elif current_slot:
		dest = current_slot.global_position + (self.size * self.scale * 0.5)
	else:
		dest = get_viewport_rect().get_center()
	var anchor = self.global_position - (self.size * self.scale * 0.5)
	self.set_position(lerp(anchor, dest, 0.5))




func _on_button_up() -> void:
	#try to go into an inv slot
	
	if !inv_manager.curr_slot_occupied():
		for node in inv.get_children():
			if node.is_class("Control"):
				# drop into a slot if we let go while they overlap
				var node_rect = Rect2(node.global_position, node.size)
				if node_rect.intersects(Rect2(self.global_position, self.size)):	
					self.current_slot = node
					inv_manager.occupy_curr_slot()

func _on_button_down() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
