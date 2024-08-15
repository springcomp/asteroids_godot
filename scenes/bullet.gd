extends Area2D

class_name Bullet

@export var speed: float = 700

@export var direction: Vector2

func _process(delta):
	position += direction * speed * delta

func _on_decay_timer_timeout():
	queue_free()
