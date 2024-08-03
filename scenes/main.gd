extends Node

class_name Main

@export var asteroid: PackedScene;

func _process(_delta):
	if Input.is_action_just_pressed("spawn"):
		spawn_asteroid()

func spawn_asteroid():
	var spawn_location = $AsteroidPath/SpawnLocation
	spawn_location.progress_ratio = randf()

	var direction = spawn_location.rotation + PI / 2;
	direction += randf_range(-PI/4, PI/4);

	var velocity = Vector2(randf_range(100, 200), 0).rotated(direction)

	var new_asteroid = asteroid.instantiate()
	new_asteroid.global_position = spawn_location.position
	new_asteroid.linear_velocity = velocity
	new_asteroid.rotation = direction;

	add_child(new_asteroid)
