class_name EquipmentLogicComponent
extends Resource

const EMPTY_EQUIPMENT_SLOT: int = -1

var helmet_item_id: int = -1
var chestplate_item_id: int = -1
var leggings_item_id: int = -1
var boots_item_id: int = -1
var weapon_item_id: int = -1

func get_item_entry(item_id: int) -> ItemEntry:
	var inventory_logic: InventoryLogicComponent = Global.get_inventory_logic()

	return inventory_logic.get_item_by_id(item_id)

func equip_new_helmet(new_helmet_item_id: int) -> void:
	var new_helmet: ItemEntry = get_item_entry(new_helmet_item_id)

	if new_helmet.item_type != "helmet":
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_helmet.item_type, "` into a slot made for fucking helmets man.")
		return
	
	helmet_item_id = new_helmet_item_id

func equip_new_chestplate(new_chestplate_item_id: int) -> void:
	var new_chestplate: ItemEntry = get_item_entry(new_chestplate_item_id)

	if new_chestplate.item_type == BaseItem.Item_Type.CHESTPLATE:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_chestplate.item_type, "` into a slot made for fucking chestplates man.")
		return
	
	chestplate_item_id = new_chestplate_item_id

func equip_new_leggings(new_leggings_item_id: int) -> void:
	var new_leggings: ItemEntry = get_item_entry(new_leggings_item_id)

	if new_leggings.item_type == BaseIt:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_leggings.item_type, "` into a slot made for fucking leggings man.")
		return
	
	leggings_item_id = new_leggings_item_id

func equip_new_boots(new_boots_item_id: int) -> void:
	var new_boots: ItemEntry = get_item_entry(new_boots_item_id)

	if new_boots.item_type != "boots":
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_boots.item_type, "` into a slot made for fucking boots man.")
		return
	
	boots_item_id = new_boots_item_id

func equip_new_weapon(new_weapon_item_id: int) -> void:
	var new_weapon: ItemEntry = get_item_entry(new_weapon_item_id)

	if new_weapon.item_type != "weapon":
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_weapon.item_type, "` into a slot made for weapons helmets man.")
		return
	
	weapon_item_id = new_weapon_item_id