extends CharacterBody2D

class_name Player

@export var max_speed: float = 10;
@export var rotation_speed: float = 3.5;
@export var velocity_damping_factor: float = .5;
@export var linear_velocity: float = 200;

var input_vector: Vector2;

## -1: rotate_left
##  0: no rotation
## +1: rotate_right
var rotation_direction: int;

func _process(_delta):
	input_vector.x = Input.get_action_strength("rotate_left") - Input.get_action_strength("rotate_right")
	input_vector.y = Input.get_action_strength("thrust")

	if Input.is_action_pressed("rotate_left"):
		rotation_direction = -1
	elif Input.is_action_pressed("rotate_right"):
		rotation_direction = +1
	else:
		rotation_direction = 0;

func _physics_process(delta: float):

	rotation += rotation_direction * rotation_speed * delta;

	if input_vector.y > 0:
		accelerate_forward(delta)
	if input_vector.y == 0 && velocity != Vector2.ZERO:
		slow_down_and_stop(delta)

	move_and_collide(velocity * delta);

func accelerate_forward(delta: float):
	velocity += (input_vector * linear_velocity * delta).rotated(rotation)
	velocity.limit_length(max_speed)

func slow_down_and_stop(delta: float):
	velocity = lerp(velocity, Vector2.ZERO, velocity_damping_factor * delta)
	if velocity.y > -0.1 && velocity.y < 0.1:
		velocity.y = 0
