extends Control


@onready var inv = get_node("../../InventoryPopout")
@onready var inv_manager = $"/root/World/HUD/InventoryManager"
@export var slot_id: int
@export var is_cauldron = false

var held_ingredient

func _ready() -> void:
	pass
	#self.mouse_entered.connect(_on_mouse_entered)
	#self.mouse_exited.connect(_on_mouse_exited)
	

func _on_mouse_entered() -> void:
	inv_manager.hovered_inv_slot = slot_id
	print("selected slot ", slot_id)

func _on_mouse_exited() -> void:
	if slot_id == inv_manager.hovered_inv_slot:
		inv_manager.hovered_inv_slot = -1
		print("selected slot ", inv_manager.hovered_inv_slot)
