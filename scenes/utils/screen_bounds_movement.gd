extends ScreenUtils2D

class_name ScreenBoundsMovement2D

@export var node: Node2D

func _ready():
	super()

func _process(_delta):
	if node.global_position.x < bounds.left:
		node.global_position.x = bounds.right
	if node.global_position.x > bounds.right:
		node.global_position.x = bounds.left

	if node.global_position.y < bounds.top:
		node.global_position.y = bounds.bottom
	if node.global_position.y > bounds.bottom:
		node.global_position.y = bounds.top
