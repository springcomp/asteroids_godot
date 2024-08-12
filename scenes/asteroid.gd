extends Area2D

class_name Asteroid

@export var asteroid_scene: PackedScene
@export var speed: float = 100

var rotation_speed: float = PI / 20

const asteroid_textures = [
	"res://arts/Asteroid_01.png",
	"res://arts/Asteroid_02.png",
	"res://arts/Asteroid_03.png",
	"res://arts/Asteroid_04.png",
]

var direction: Vector2

func _ready():
	direction = Vector2(0, 1).rotated(rotation)

func _process(delta: float):
	position += direction * speed * delta
	rotation += rotation_speed * delta