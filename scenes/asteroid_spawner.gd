extends Node

const Utils = preload("res://scenes/utils/asteroid_size.gd")

signal on_asteroid_destroyed(size: Utils.AsteroidSize)
signal on_game_won()

@export var asteroid_scene: PackedScene
@export var level_asteroid_counts = [
	6,
	8,
	12,
	20
]

@export var level_asteroid_speeds = [
	100,
	150,
	175,
	200
]

@onready var spawn_location: PathFollow2D = $ScreenEdges/SpawnLocation

var screen_size: Vector2 

var level = 0

var total_asteroid_count: int
var destroyed_asteroid_count: int = 0

func _ready():
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var zoom = camera.zoom
	screen_size = rect.size / zoom

	start_level()

func start_level():
	var count = level_asteroid_counts[level]

	total_asteroid_count = count * 7
	destroyed_asteroid_count = 0

	for i in range(count):
		spawn_location.progress_ratio = randf()
		var direction = spawn_location.rotation + PI / 2
		direction += randf_range(- PI / 4, + PI / 4)
		spawn_asteroid(spawn_location.position, direction, Utils.AsteroidSize.BIG)

func spawn_asteroid(position: Vector2, direction: float, size: Utils.AsteroidSize):
	var asteroid = asteroid_scene.instantiate() as Asteroid
	asteroid.global_position = position
	asteroid.rotation = direction
	asteroid.size = size
	asteroid.speed = level_asteroid_speeds[level]
	asteroid.on_destroyed.connect(_on_asteroid_destroyed)

	get_tree().root.add_child.call_deferred(asteroid)

func _on_asteroid_destroyed(position: Vector2, size: Utils.AsteroidSize):
	on_asteroid_destroyed.emit(size)
	destroyed_asteroid_count += 1

	if size != Utils.AsteroidSize.SMALL:
		var nextSize = size + 1
		for i in range(2):
			var direction = randf_range(-PI, PI)
			spawn_asteroid(position, direction, nextSize)

	if destroyed_asteroid_count == total_asteroid_count:
		level += 1
		if level >= level_asteroid_counts.size():
			on_game_won.emit()
		else:
			start_level()
