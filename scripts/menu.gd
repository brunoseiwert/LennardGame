extends Container

onready var gj = $"GameJoltAPI"
onready var playMenu = $"playMenu"
onready var highscores = $"highscores"
onready var nameEdit = $"playMenu/nameEdit"

func _ready():
	var saveGame = File.new()
	if saveGame.file_exists("user://lastname.save"):
		saveGame.open("user://lastname.save", File.READ)
		nameEdit.text = saveGame.get_line()
		saveGame.close()
	gj.fetch_scores("", "", 20, "376312")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_F11:
				OS.set_window_fullscreen(!OS.window_fullscreen)
			elif event.scancode == KEY_F8:
				get_tree().quit()

func start():
	global.playerName = $"playMenu/nameEdit".text
	var saveGame = File.new()
	saveGame.open("user://lastname.save", File.WRITE)
	saveGame.store_string(global.playerName)
	saveGame.close()
	get_tree().change_scene("res://scenes/Main.tscn")

func exit():
	get_tree().quit()

func _on_GameJoltAPI_api_scores_fetched(data):
	var scores = parse_json(data).response.scores
	
	var i = 0
	for s in scores:
		get_node("highscores/" + str(i+1)).text = str(i+1) + ". " +  s.guest
		get_node("highscores/" + str(i+1) + "/score").text = "        " + s.score
		i += 1

func showHighscores():
	playMenu.hide()
	highscores.show()
	
func showPlayMenu():
	highscores.hide()
	playMenu.show()
