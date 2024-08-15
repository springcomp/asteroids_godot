extends Area2D

class_name Asteroid

const Utils = preload("res://scenes/utils/asteroid_size.gd")

signal on_destroyed(position: Vector2, size: Utils.AsteroidSize)

@export var speed: float = 100

@onready var sprite = $Sprite2D
@onready var explosion_particles: CPUParticles2D = $ExplosionParticles

const rotation_speeds = [
	PI / 20,
	PI / 12,
	PI / 6
]

const asteroid_textures = [
	"res://arts/Asteroid_01.png",
	"res://arts/Asteroid_02.png",
	"res://arts/Asteroid_03.png",
	"res://arts/Asteroid_04.png",
]

var direction: Vector2
var size: Utils.AsteroidSize
var rotation_speed: float = PI / 20
var exploding: bool = false

func _ready():
	direction = Vector2(0, 1).rotated(rotation)

	var scale_value = 1.0 / (size + 1.0)
	scale = Vector2(scale_value, scale_value)

	rotation_speed = rotation_speeds[size]

	var image_index = randi() % asteroid_textures.size()
	var random_texture = load(asteroid_textures[image_index])
	sprite.texture = random_texture

func _process(delta: float):
	position += direction * speed * delta
	rotation += rotation_speed * delta

func _on_area_entered(area: Area2D):
	if exploding:
		return
		
	if area is Bullet:
		area.queue_free()
		on_destroy()

func _on_body_entered(body: CharacterBody2D):
	if exploding:
		return

	if body is Player && !(body as Player).invincible:
		body.destroy()
		on_destroy()

func on_destroy():
	exploding = true
	explode()
	on_destroyed.emit(position, size)

func explode():
	sprite.visible = false
	
	## works around a bug that
	## prevents finished signal
	## from being fired
	
	explosion_particles.emitting = false
	explosion_particles.one_shot = true
	explosion_particles.emitting = true
	
	explosion_particles.finished.connect(on_explosion_particles_finished)
	
func on_explosion_particles_finished():
	queue_free()
