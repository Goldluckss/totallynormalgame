# area_manager.gd
extends Node

var current_scene = "Home"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Handle transitioning between scenes
func transition_to_scene(scene_name: String, spawn_position: Vector2 = Vector2.ZERO) -> void:
	# Print time before transition
	if DayAndNightCycleManager:
		print("Time before transition: ", DayAndNightCycleManager.get_time_string())
		var time_data = DayAndNightCycleManager.get_current_time()
		print("Raw time data - Day: %d, Hour: %d, Minute: %d" % [time_data.day, time_data.hour, time_data.minute])
		print("Raw time value: ", DayAndNightCycleManager.time)
	else:
		print("ERROR: DayAndNightCycleManager not found!")
	
	# Determine the scene path based on the scene name
	var next_scene_path = ""
	match scene_name:
		"Home":
			next_scene_path = "res://scenes/areas/home.tscn"
		"Route":
			next_scene_path = "res://scenes/areas/route.tscn"
		_:
			print("Unknown scene name: ", scene_name)
			return
			
	# Use call_deferred to load and change the scene
	call_deferred("_deferred_transition_to_scene", next_scene_path, spawn_position, scene_name)

# New method to handle the deferred transition
func _deferred_transition_to_scene(next_scene_path: String, spawn_position: Vector2, scene_name: String) -> void:
	# Print time after transition starts
	if DayAndNightCycleManager:
		print("Time after transition starts: ", DayAndNightCycleManager.get_time_string())
	
	# Load the new scene
	var next_scene = load(next_scene_path).instantiate()
	
	# Add it to the tree and remove the old scene
	get_tree().root.add_child(next_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = next_scene
	
	# Find the player in the new scene and set its position
	var player = next_scene.find_child("Player")
	if player and spawn_position != Vector2.ZERO:
		player.global_position = spawn_position
	
	current_scene = scene_name
	
	# Print time after transition completes
	if DayAndNightCycleManager:
		print("Time after transition completes: ", DayAndNightCycleManager.get_time_string())
	else:
		print("ERROR: DayAndNightCycleManager not accessible after transition!")
