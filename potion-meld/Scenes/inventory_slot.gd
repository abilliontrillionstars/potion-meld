extends Control

@onready var inv = get_node("../../InventoryPopout")

func _on_mouse_entered() -> void:
	var slotnum = int(str(self.name)[-1])
	inv.selected_slot = slotnum
	print("selected slot ", slotnum)

func _on_mouse_exited() -> void:
	pass # Replace with function body.
