extends Node2D

export(bool) var spawning

export(PackedScene) var enemy1
export(PackedScene) var enemy2
export(PackedScene) var enemy3
export(PackedScene) var enemy4

onready var rightSpawner = $"RightSpawner"
onready var leftSpawner = $"LeftSpawner"

var waves = [
	[8, 0, 0, 0],
	[4, 2, 0, 0],
	[12, 2, 2, 0],
	[8, 5, 3, 1],
	[8, 4, 4, 2],
	[10, 6, 3, 3],
	[10, 0, 8, 4],
	[0, 2, 2, 6],
	[10, 6, 6, 4],
	[8, 10, 8, 0],
	[12, 12, 4, 2],
	[8, 12, 10, 6],
	[4, 4, 12, 8],
	[4, 4, 0, 10],
	[2, 10, 2, 8],
	[6, 6, 14, 6]
]

var lvl = 0
var enemyCount = 0

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	if spawning:
		spawn()

func spawn():
	enemyCount = waves[lvl][0] + waves[lvl][1] + waves[lvl][2] + waves[lvl][3]
	print("######## " + "LEVEL: " + str(lvl) + " ########")
	print("Enemy count: " + str(enemyCount))
	print("########")
	
	#solange man gegner spawnen kann, wird gespawnt
	for i in range(0, enemyCount):
		#random gegner-nummer wird gewählt
		var en = floor(rand_range(0, 4))
		var e
		
		#falls es keinen enemy mit en mehr gibt, muss en neu bestimmt werden
		while waves[lvl][en] == 0:
			en = floor(rand_range(0, 4))
		
		#gegner wird gespawnt
		if en == 0:
			e = enemy1.instance()
			waves[lvl][0] -= 1
		if en == 1:
			e = enemy2.instance()
			waves[lvl][1] -= 1
		if en == 2:
			e = enemy3.instance()
			waves[lvl][2] -= 1
		if en == 3:
			e = enemy4.instance()
			waves[lvl][3] -= 1
		
		$"/root/Game".add_child(e)
		
		if i % 2 == 0:
			e.global_position = rightSpawner.global_position
		else:
			e.global_position = leftSpawner.global_position
		e.global_position.x += rand_range(-24, 24)
		
		e.decideDirection()
		
		yield(get_tree().create_timer(0.8), "timeout")
		
func reduceEnemyCount():
	enemyCount -= 1
	if enemyCount <= 0:
		lvl += 1
		if lvl < waves.size() && spawning:
			spawn()
		else:
			print("Game Won!!")