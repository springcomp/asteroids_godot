extends Area2D

class_name Asteroid

const Utils = preload("res://scenes/Utils/utils.gd")

signal on_destroyed(position: Vector2, size: Utils.AsteroidSize)

@export var speed: float = 100
@export var speed_increment_factor: float = .3

@onready var sprite = $Sprite2D
@onready var explosion_particles = $ExplosionParticles

var image_array = [
	"res://arts/Asteroid_01.png",
	"res://arts/Asteroid_02.png",
	"res://arts/Asteroid_03.png",
	"res://arts/Asteroid_04.png",
	]

var direction: Vector2
var size: Utils.AsteroidSize

func _ready():

	var x = randf_range(-1, 1)
	var y = randf_range(-1, 1)
	direction = Vector2(x, y)

	var scale_value = 1 / ( size + 1.0 )
	scale = Vector2(scale_value, scale_value)

	## smaller asteroids move faster
	speed += speed_increment_factor * size * speed

	var image_index = randi() % image_array.size()
	var random_image = load(image_array[image_index])
	sprite.texture = random_image


func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area: Area2D):
	if area is Bullet:
		area.queue_free()
		on_destroy()

func _on_body_entered(body: CharacterBody2D):
	if body is Player:
		body.on_player_died.emit()
		body.queue_free()
		on_destroy()

func on_destroy():
	explode()
	queue_free()
	on_destroyed.emit(position, size)

func explode():
	explosion_particles.emitting = true
	explosion_particles.reparent(get_tree().root)
