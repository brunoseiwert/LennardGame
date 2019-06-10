extends "res://scripts/bases/actor.gd"

export(String) var ENEMY_VARIABLES = "========"
export(int) var GRAVITY
export(int) var movSpeed
export(int) var jumpForce

onready var player = $"/root/Game/Player"

func _ready():
	pass
	
func _physics_process(delta):
	calcMov()

func calcMov():
	pass