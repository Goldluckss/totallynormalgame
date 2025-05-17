extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction = player.player_direction
	
	# Determine idle animation based on the dominant direction
	if direction.length() > 0:
		if abs(direction.y) > abs(direction.x):
			# Vertical direction is dominant
			if direction.y < 0:
				animated_sprite_2d.play("idle_back")
			else:
				animated_sprite_2d.play("idle_front")
		else:
			# Horizontal direction is dominant
			if direction.x > 0:
				animated_sprite_2d.play("idle_right")
			else:
				animated_sprite_2d.play("idle_left")
	else:
		# Default to front if no direction
		animated_sprite_2d.play("idle_front")


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	
	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvents.use_tool():
		transition.emit("Chopping")
	
	if player.current_tool == DataTypes.Tools.TiltGround && GameInputEvents.use_tool():
		transition.emit("Tilling")
	
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvents.use_tool():
		transition.emit("Watering")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
