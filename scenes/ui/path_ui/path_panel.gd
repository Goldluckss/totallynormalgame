extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling


func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)


func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TiltGround)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_RIGHT:
			ToolManager.select_tool(DataTypes.Tools.None)
			tool_axe.release_focus()
			tool_tilling.release_focus()
