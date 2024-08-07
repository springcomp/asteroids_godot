extends Node

class_name PointsManager

const Utils = preload("res://scenes/Utils/utils.gd")

signal on_points_updated(points: int)

var points: int = 0

func on_asteroid_destroyed(size: Utils.AsteroidSize):
	if size == Utils.AsteroidSize.BIG:
		points += 50
	elif size == Utils.AsteroidSize.MEDIUM:
		points += 125
	elif size == Utils.AsteroidSize.SMALL:
		points += 175

	on_points_updated.emit(points)

func on_ufo_destroyed():
	points += 200
	on_points_updated.emit(points)

func _on_lives_manager_on_player_life_lost(_lives_left:int):
	points -= 100
	on_points_updated.emit(points)
