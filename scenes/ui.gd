extends CanvasLayer

@onready var lives_container: HBoxContainer = $MarginContainer/LivesContainer
@onready var lives_manager: LivesManager = $"../LivesManager"
@onready var game_over_label: Label = $"MarginContainer/GameOverContainer/GameOverLabel"

var lives_texture = preload("res://arts/lives.png");
var empty_life_texture = preload("res://arts/player.png")

func _ready():
	var lives = lives_manager.lives
	for i in range(lives):
		var lives_texture_rect = TextureRect.new()
		lives_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		lives_texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		lives_texture_rect.texture = lives_texture
		lives_texture_rect.custom_minimum_size = Vector2(32, 32)
		lives_container.add_child(lives_texture_rect)

	lives_manager.on_player_life_lost.connect(on_player_life_lost)

func on_player_life_lost(lives_left: int):
	var lives_texture_rect: TextureRect = lives_container.get_child(lives_left + 1)
	lives_texture_rect.texture = empty_life_texture
	if (lives_left == 0):
		game_over_label.visible = true