extends Node2D

onready var spawner = $"Level/Spawner"
onready var healthBar = $"UiLayer/HealthBar"
onready var scoreLabel = $"UiLayer/ScoreLabel"
onready var scoreText = $"UiLayer/ScoreText"
onready var gameOverContainer = $"UiLayer/GameOverContainer"
onready var gj = $"GameJoltAPI"

var score = 0

func _ready():
	randomize()
	gj.fetch_scores("10")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_F11:
				OS.set_window_fullscreen(!OS.window_fullscreen)
			elif event.scancode == KEY_F8:
				get_tree().quit()
				

func increaseScore(amt):
	score += amt
	scoreLabel.bbcode_text = "[center]" + str(score) + "[/center]"
	gameOverContainer.setScore(score)

func _on_House_game_over():
	spawner.spawning = false
	healthBar.visible = false
	scoreLabel.visible = false
	scoreText.visible = false
	gameOverContainer.show()
	uploadScore()
	get_tree().paused = true
	print("GAME OVER")
	
func restart():
	get_tree().change_scene("res://scenes/Main.tscn")
	get_tree().paused = false
	
func uploadScore():
	#uses gamjolt api with plugin by 'ackens'
	if score > 0:
		gj.add_score(str(score), score, "", "", global.playerName, "376312")

func _on_GameJoltAPI_api_scores_fetched(data):
	print(data)

func _on_GameJoltAPI_api_scores_added(success):
	print(success)
