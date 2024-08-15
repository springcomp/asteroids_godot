extends ScreenUtils2D

class_name VisibleOnScreenTeller2D

@export var node: Node2D
@export var margin_top: float = 0
@export var margin_left: float = 0
@export var margin_right: float = 0
@export var margin_bottom: float = 0

var viewport: Dictionary = {}

func _ready():
	super()
	viewport = self.bounds
	viewport.top += margin_top
	viewport.left += margin_left
	viewport.bottom -= margin_bottom
	viewport.right -= margin_right

func is_visible_on_screen() -> bool:
	if node.global_position.y < viewport.top:
		return false
	if node.global_position.x < viewport.left:
		return false

	if node.global_position.y > viewport.bottom:
		return false
	if node.global_position.x > viewport.right:
		return false
		
	return true
