extends Container

onready var game = $"/root/Game"
onready var tween = $"Tween"
onready var particles = $"Particles2D"
onready var menu = $"Menu"
onready var schoppeLabel = $"Menu/SchoppeLabel"
	
	
func setScore(i):
	schoppeLabel.bbcode_text = "[center]" + global.playerName + " collected " + str(i) + " Schoppe!!![/center]"

func show():
	self.visible = true
	tween.interpolate_property(menu, "modulate", Color(0,0,0,0), Color(1,1,1,1), 1,Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	particles.emitting = true

func restartGame():
	game.restart()

func backToMenu():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menu.tscn")
