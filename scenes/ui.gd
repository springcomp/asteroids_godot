extends CanvasLayer

@onready var lives_container: HBoxContainer = $MarginContainer/LivesContainer
@onready var lives_manager: LivesManager = $LivesManager

@onready var points_label: Label = $MarginContainer/PointsContainer/PointsLabel
@onready var game_over_label: Label = $MarginContainer/CenterContainer/GameOverLabel

var lives_texture = load("res://arts/lives.png")
var empty_texture = load("res://arts/player.png")

func _ready():
	var lives = lives_manager.lives
	for i in range(lives):
		var lives_texture_rect = TextureRect.new()
		lives_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		lives_texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		lives_texture_rect.texture = lives_texture
		lives_texture_rect.custom_minimum_size = Vector2(32, 32)
		lives_container.add_child(lives_texture_rect)

func _on_lives_manager_on_player_life_lost(lives_left):
	var lives_texture_rect = lives_container.get_child(lives_left)
	lives_texture_rect.texture = empty_texture

func _on_lives_manager_on_game_over():
	game_over_label.visible = true

func _on_points_manager_on_points_updated(points: int):
	points_label.text = "%s" % [ points ]

func _on_asteroid_spawner_on_game_won():
	game_over_label.text = "You won!"
	game_over_label.add_theme_color_override("font_color", Color.CHARTREUSE)
	game_over_label.visible = true
