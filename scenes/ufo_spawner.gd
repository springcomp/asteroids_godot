extends Node

class_name UfoSpawner

@onready var timer: Timer = $SpawnTimer
@onready var topPath: PathFollow2D = $PathTopLeft/PathFollow2D
@onready var bottomPath: PathFollow2D = $PathBottomRight/PathFollow2D

@export var ufo_scene: PackedScene

func _on_spawn_timer_timeout():
	spawn_ufo()

func spawn_ufo():
	var path_to_follow = [topPath, bottomPath][randi() % 2]
	path_to_follow.progress = 0

	var ufo = ufo_scene.instantiate() as Ufo
	ufo.path = path_to_follow
	ufo.global_position = path_to_follow.position
	ufo.on_destroyed.connect(on_ufo_destroyed)

	get_tree().root.get_node("Main").add_child.call_deferred(ufo)

func on_ufo_destroyed():
	timer.setup_timer()