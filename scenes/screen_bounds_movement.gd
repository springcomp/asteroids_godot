extends Node

@export var node: Node2D

var bounds: Dictionary = {}

func _ready():
	var camera = get_viewport().get_camera_2d()
	var zoom = camera.zoom
	var center = camera.position

	var rect = get_viewport().get_visible_rect()
	var size = rect.size / zoom

	bounds.top    = (center.y - size.y) / 2
	bounds.left   = (center.x - size.x) / 2
	bounds.right  = (center.x + size.x) / 2
	bounds.bottom = (center.y + size.y) / 2

func _process(_delta):
	if node.global_position.x < bounds.left:
		node.global_position.x = bounds.right
	if node.global_position.x > bounds.right:
		node.global_position.x = bounds.left

	if node.global_position.y < bounds.top:
		node.global_position.y = bounds.bottom
	if node.global_position.y > bounds.bottom:
		node.global_position.y = bounds.top