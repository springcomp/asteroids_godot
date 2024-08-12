extends Node

@export var asteroid_scene: PackedScene
@export var count: int = 6

@onready var spawn_location: PathFollow2D = $ScreenEdges/SpawnLocation

func _ready():
	for i in range(count):
		spawn_location.progress_ratio = randf()
		var direction = spawn_location.rotation + PI / 2
		direction += randf_range(- PI / 4, + PI / 4)
		spawn_asteroid(spawn_location.position, direction)

func spawn_asteroid(position: Vector2, direction: float):
	var asteroid = asteroid_scene.instantiate() as Asteroid
	asteroid.global_position = position
	asteroid.rotation = direction

	get_tree().root.add_child.call_deferred(asteroid)
