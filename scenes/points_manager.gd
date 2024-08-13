extends Node

class_name PointsManager

const Utils = preload("res://scenes/utils/asteroid_size.gd")

signal on_points_updated(points: int)

var points: int = 0

func _on_lives_manager_on_player_life_lost(_lives_left):
	points -= 100
	on_points_updated.emit(points)

func _on_asteroid_spawner_on_asteroid_destroyed(size: Utils.AsteroidSize):
	if size == Utils.AsteroidSize.BIG:
		points += 50
	elif size == Utils.AsteroidSize.MEDIUM:
		points += 125
	elif size == Utils.AsteroidSize.SMALL:
		points += 175
	else:
		pass
	
	on_points_updated.emit(points)
