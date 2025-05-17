class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("walk_left"):
		direction.x = -1
	elif Input.is_action_pressed("walk_right"):
		direction.x = 1
		
	if Input.is_action_pressed("walk_up"):
		direction.y = -1
	elif Input.is_action_pressed("walk_down"):
		direction.y = 1
	
	return direction
	
static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true
