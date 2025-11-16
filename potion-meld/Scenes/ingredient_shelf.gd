extends Node

@onready var IItem = $"../DraggableItem"

func _ready() -> void:
	for node in self.get_children():
		node.add_child(IItem.duplicate())
		var item = node.get_child(0)
		item.current_slot = node
		item.set_position(Vector2())
		
