extends Timer

class_name UfoSpawnTimer

@export var min_time_in_seconds: int = 5
@export var max_time_in_seconds: int = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_timer()

func setup_timer():
	var timeout_value = 5 ## randi_range(min_time_in_seconds, max_time_in_seconds)
	self.wait_time = timeout_value
	self.start()