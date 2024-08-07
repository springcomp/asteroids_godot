extends Node

class_name AsteroidSpawner

const Utils = preload("res://scenes/Utils/utils.gd")

signal game_won()

@onready var spawn_location: PathFollow2D = $AsteroidPath/SpawnLocation
@onready var points_manager = $"../UI/PointsManager"

@export var asteroid_scene: PackedScene
@export var count: int = 6

var total_asteroid_count: int = 0
var destroyed_asteroid_count: int = 0

func _ready():
	spawn_asteroids()
	total_asteroid_count = count * 7

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

func _on_asteroid_destroyed(position: Vector2, size: Utils.AsteroidSize):

	points_manager.on_asteroid_destroyed(size)

	if size != Utils.AsteroidSize.SMALL:
		var new_size = size + 1;
		for i in range(2):
			spawn_asteroid(position, new_size);

	destroyed_asteroid_count += 1
	if (destroyed_asteroid_count == total_asteroid_count):
		## spawn a new level
		## count += (count >> 1)
		## spawn_asteroids()

		## wins game
		game_won.emit()
