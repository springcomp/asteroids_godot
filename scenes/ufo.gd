extends Area2D

class_name Ufo

signal on_destroyed()
signal on_vanished()

@onready var explosion_particles: ExplosionParticles = $ExplosionParticles
@export var path: PathFollow2D

var speed: int = 300

func _process(delta: float):
	if path == null:
		return

	var progress = speed * delta;
	path.progress += speed * delta;
	global_position = path.position

func _on_area_entered(area: Area2D):
	if area is Bullet:
		area.queue_free()
		on_destroy()
	if area is Asteroid:
		area.on_destroyed.emit(area.global_position, area.size)
		area.queue_free()
		on_destroy()

func _on_body_entered(body: CharacterBody2D):
	if body is Player && !(body as Player).is_invincible:
		body.on_player_died.emit()
		body.queue_free()
		on_destroy()

func on_destroy():
	explode()
	queue_free()
	on_destroyed.emit()

func explode():
	explosion_particles.emitting = true
	explosion_particles.reparent(get_tree().root)

func _on_visible_on_screen_notifier_2d_screen_exited():
	on_vanished.emit()
	queue_free()
