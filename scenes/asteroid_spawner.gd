extends Node

class_name AsteroidSpawner

@export var asteroid_scene: PackedScene
@export var spawn_location: PathFollow2D

@export var count: int = 6

const Utils = preload("res://scenes/Utils/utils.gd")

func _ready():
	for i in range(count):
		spawn_location.progress_ratio = randf()
		var random_spawn_position = spawn_location.position
		spawn_asteroid(random_spawn_position, Utils.AsteroidSize.BIG)

func spawn_asteroid(position: Vector2, size: Utils.AsteroidSize):
	var asteroid = asteroid_scene.instantiate() as Asteroid
	asteroid.on_destroyed.connect(_on_asteroid_destroyed)
	asteroid.global_position = position
	asteroid.size = size
	get_tree().root.add_child.call_deferred(asteroid)

func _on_asteroid_destroyed(position: Vector2, size: Utils.AsteroidSize):
	if size != Utils.AsteroidSize.SMALL:
		var new_size = size + 1;
		for i in range(2):
			spawn_asteroid(position, new_size);