extends PanelContainer
@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var corn_label: Label = $MarginContainer/VBoxContainer/Corn/CornLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/Tomato/TomatoLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel


func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	# Add this line to refresh the display immediately when the scene loads
	update_display()

func update_display() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	# Update each label, showing 0 if the item doesn't exist in inventory
	log_label.text = str(inventory.get("log", 0))
	stone_label.text = str(inventory.get("stone", 0))
	corn_label.text = str(inventory.get("corn", 0))
	tomato_label.text = str(inventory.get("tomato", 0))
	egg_label.text = str(inventory.get("egg", 0))
	milk_label.text = str(inventory.get("milk", 0))
	
func on_inventory_changed() -> void:
	update_display()
