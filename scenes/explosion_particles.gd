extends CPUParticles2D

class_name ExplosionParticles

@onready var timer: Timer = $ExplosionTimer

func explode():
	timer.wait_time = lifetime
	timer.timeout.connect(on_timer_timeout)
	timer.start()

	emitting = true

func on_timer_timeout():
	queue_free()