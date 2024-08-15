extends Node

class_name ScreenUtils2D

var bounds: Dictionary = {}

func _ready():
	bounds = get_screen_bounds()

func get_screen_bounds() -> Dictionary:
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var zoom = camera.zoom
	var center = camera.position

	var size = rect.size / zoom

	return {
		top = (center.y - size.y) / 2,
		left = (center.x - size.x) / 2,
		right = (center.x + size.x) / 2,
		bottom = (center.y + size.y) / 2,
	}
