extends Node

class_name LivesManager

signal on_player_life_lost(lives_left: int)

@export var lives: int = 3
@export var player_scene: PackedScene = preload("res://scenes/player.tscn")

@onready var player: Player = $"../../Player"

const player_start_position = Vector2(0, 0)

func _ready():
	player.on_player_died.connect(decrease_lives)
	
func decrease_lives():
	lives -= 1
	on_player_life_lost.emit(lives)
	if lives != 0:
		var new_player = player_scene.instantiate() as Player
		new_player.on_player_died.connect(decrease_lives)
		get_tree().root.get_node("Main").add_child.call_deferred(new_player)
