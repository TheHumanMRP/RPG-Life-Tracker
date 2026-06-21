extends Control

@export var item: BaseItem
@export var accepted_item_type: String = "base_item"

@onready var display_logo: TextureRect = $%Logo_Display

func _ready() -> void:
	check_type_of_item()
	SignalBus.refresh_ui.connect(refresh_ui)

func refresh_ui() -> void:
	if item:
		display_logo.texture = item.logo

func check_type_of_item() -> void:
	if not accepted_item_type == "base_item":
		if not item.type == accepted_item_type:
			push_error("Inventory Slot: Invalid item type ")
			item = BaseItem.new()