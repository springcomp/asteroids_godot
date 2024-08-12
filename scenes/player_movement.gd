extends CharacterBody2D

class_name Player

## -1: rotates right
##  0: does not rotate
## +1: rotates left
var rotation_direction: int = 0
var rotation_speed: float = PI

var input_vector: Vector2

var linear_acceleration: float = 300
var max_velocity: float = 700
var velocity_damping_factor: float = 0.5

func _process(_delta: float):
	input_vector.x = Input.get_action_strength("rotate_left") - Input.get_action_strength("rotate_right");
	input_vector.y = Input.get_action_strength("thrust");

	if Input.is_action_pressed("rotate_left"):
		rotation_direction = -1
	elif Input.is_action_pressed("rotate_right"):
		rotation_direction = +1
	else:
		rotation_direction = 0

func _physics_process(delta: float):
	rotation += rotation_direction * rotation_speed * delta

	if input_vector.y > 0:
		accelerate_forward(delta)
	if input_vector.y == 0 && velocity != Vector2.ZERO:
		slow_down_and_stop(delta)

	move_and_collide(velocity * delta)

func accelerate_forward(delta: float):
	velocity += (input_vector * linear_acceleration).rotated(rotation) * delta
	velocity = velocity.limit_length(max_velocity)

func slow_down_and_stop(delta: float):
	velocity = lerp(velocity, Vector2.ZERO, velocity_damping_factor * delta)
	if velocity.y > -0.1 && velocity.y < 0.1:
		velocity = Vector2.ZERO