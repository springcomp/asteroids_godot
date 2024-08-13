extends Node

const Utils = preload("res://scenes/utils/asteroid_size.gd")

@export var asteroid_scene: PackedScene
@export var count: int = 6

@onready var spawn_location: PathFollow2D = $ScreenEdges/SpawnLocation

var screen_size: Vector2 

func _ready():
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var zoom = camera.zoom
	screen_size = rect.size / zoom

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
	asteroid.on_destroyed.connect(on_asteroid_destroyed)

	get_tree().root.add_child.call_deferred(asteroid)

func on_asteroid_destroyed(position: Vector2, size: Utils.AsteroidSize):
	if size != Utils.AsteroidSize.SMALL:
		var nextSize = size + 1
		for i in range(2):
			var direction = randf_range(-PI, PI)
			spawn_asteroid(position, direction, nextSize)
