extends Area2D

class_name Asteroid

const Utils = preload("res://scenes/utils/asteroid_size.gd")

signal on_destroyed(position: Vector2, size: Utils.AsteroidSize)

@export var asteroid_scene: PackedScene
@export var speed: float = 100

@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion_particles: ExplosionParticles = $ExplosionParticles

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
	if area is Bullet:
		area.queue_free()
		on_destroy()

func _on_body_entered(body: CharacterBody2D):
	if body is Player:
		body.destroy()
		on_destroy()

func on_destroy():
	explode()
	on_destroyed.emit(position, size)
	queue_free()

func explode():
	explosion_particles.reparent(get_tree().root)
	explosion_particles.explode()
