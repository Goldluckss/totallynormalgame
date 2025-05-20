class_name AreaTransition
extends Area2D

@export var target_scene: String = ""
@export var player_spawn_position: Vector2 = Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# Call the AreaManager to handle the transition
		print("Transition")
		AreaManager.transition_to_scene(target_scene, player_spawn_position)
