extends Node

class_name LivesManager

signal on_player_life_lost(lives_left: int)
signal on_game_over()

@export var player_scene: PackedScene

@onready var player: Player = $"../../Player"
@export var lives: int = 3

var player_start_position = Vector2(0, 0)

func _ready():
	player.on_died.connect(on_player_died)

func on_player_died():
	lives -= 1
	on_player_life_lost.emit(lives)
	if lives == 0:
		on_game_over.emit()
	else:
		spawn_new_player()

func spawn_new_player():
	var new_player = player_scene.instantiate() as Player
	new_player.global_position = player_start_position
	new_player.on_died.connect(on_player_died)

	get_tree().root.get_node("Main").add_child.call_deferred(new_player)
