extends Node

class_name AsteroidSpawner

signal points_updated(points: int)

@export var asteroid_scene: PackedScene
@export var spawn_location: PathFollow2D

@export var count: int = 6

const Utils = preload("res://scenes/Utils/utils.gd")

var points: int = 0
var total_asteroid_count: int = 0
var destroyed_asteroid_count: int = 0

func _ready():
	spawn_asteroids()

func spawn_asteroids():
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

	total_asteroid_count += 1

func _on_asteroid_destroyed(position: Vector2, size: Utils.AsteroidSize):

	destroyed_asteroid_count +=1

	if size == Utils.AsteroidSize.BIG:
		points += 50
	elif size == Utils.AsteroidSize.MEDIUM:
		points += 125
	elif size == Utils.AsteroidSize.SMALL:
		points += 175

	points_updated.emit(points)

	if size != Utils.AsteroidSize.SMALL:
		var new_size = size + 1;
		for i in range(2):
			spawn_asteroid(position, new_size);

	if (destroyed_asteroid_count == total_asteroid_count):
		count += (count >> 1)
		spawn_asteroids()