extends "res://scripts/bases/actor.gd"

var dir = 0
var mov = Vector2()

export(String) var ENEMY_VARIABLES = "========"
export(int) var GRAVITY = 15
export(int) var movSpeed
export(int) var jumpForce = 100

export(int) var damage = 1

export(PackedScene) var corpse
export(PackedScene) var schoppe

export(Material) var hitEffectMaterial
export(Material) var normalMaterial

onready var player = $"/root/Game/Player"
onready var house = $"/root/Game/Level/House"
onready var spawner = $"/root/Game/Level/Spawner"
onready var animatedSprite = $"AnimatedSprite"
onready var hitEffectTimer = $"HitEffectTimer"

var deltapos = Vector2()
var newpos = Vector2()
	
func _physics_process(delta):
	calcMov()
	
	deltapos = newpos
	newpos = self.global_position

func calcMov():
	mov.y += GRAVITY
	
	mov = move_and_slide(Vector2(dir * movSpeed, mov.y), FLOOR_NORMAL)
	
func damageEffect():
	self.material = hitEffectMaterial
	hitEffectTimer.start()
	

func die():
	if !dead:
		spawner.reduceEnemyCount()
		dead = true
		spawnCorpse()
		dropSchoppe()
	self.queue_free()

func execute():
	if !dead:
		spawner.reduceEnemyCount()
		dead = true
	self.queue_free()

func dropSchoppe():
	var schop = schoppe.instance()
	$"/root/Game".add_child(schop)
	schop.global_position = self.global_position

func spawnCorpse():
	var cor = corpse.instance()
	$"/root/Game".add_child(cor)
	cor.global_position = self.global_position
	cor.flip_h = $"AnimatedSprite".flip_h
	
func decideDirection():
	if house.global_position.x > self.global_position.x:
		dir = 1
		$"AnimatedSprite".flip_h = false
	else:
		dir = -1
		$"AnimatedSprite".flip_h = true

func setNormalMat():
	self.material = normalMaterial

func correctPos():
	self.global_position = deltapos
