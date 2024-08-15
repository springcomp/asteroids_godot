extends Node2D

@export var bullet_scene: PackedScene
@onready var visible_on_screen_teller: ScreenUtils2D = $VisibleOnScreenTeller2D

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	if visible_on_screen_teller.is_visible_on_screen():
		var bullet = bullet_scene.instantiate() as Bullet
		bullet.global_position = global_position
		bullet.direction = Vector2(0, 1).rotated(get_parent().rotation)

		get_tree().root.add_child.call_deferred(bullet)
