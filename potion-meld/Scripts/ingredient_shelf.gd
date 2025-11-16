extends Node

@export var shelf_panels: Array[Panel]
@onready var IItem = $"../DraggableItem"

func hide_hitboxes():
	print ("hiding hitboxes")
	for i in range(0, shelf_panels.size()):
		shelf_panels[i].mouse_filter = Control.MOUSE_FILTER_IGNORE

func show_hitboxes():
	print ("showing hitboxes")
	for i in range(0, shelf_panels.size()):
		shelf_panels[i].mouse_filter = Control.MOUSE_FILTER_STOP

#func _ready() -> void:
	#for node in self.get_children():
		#node.add_child(IItem.duplicate())
		#var item = node.get_child(0)
		#item.current_slot = node
		#item.set_position(Vector2())
		
