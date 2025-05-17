extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	# Normalize the vector to prevent faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()
		player.player_direction = direction
		
		# Determine animation based on the dominant direction
		if abs(direction.y) > abs(direction.x):
			# Vertical movement is dominant
			if direction.y < 0:
				animated_sprite_2d.play("walk_back")
			else:
				animated_sprite_2d.play("walk_front")
		else:
			# Horizontal movement is dominant
			if direction.x > 0:
				animated_sprite_2d.play("walk_right")
			else:
				animated_sprite_2d.play("walk_left")
	
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
