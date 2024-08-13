extends Node2D

@export var bullet_scene: PackedScene

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate() as Bullet
	bullet.global_position = global_position
	bullet.direction = Vector2(0, 1).rotated(get_parent().rotation)

	get_tree().root.add_child.call_deferred(bullet)