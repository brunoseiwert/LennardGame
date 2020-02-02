extends KinematicBody2D

export(PackedScene) var explosion
export(PackedScene) var particles

var bulSpeed = 500
var dir = Vector2()
var damage = 1

var tim
var col
var par

func _ready():
	par = particles.instance()
	$"/root/Game".add_child(par)
	
	tim = Timer.new()
	tim.wait_time = 3
	tim.connect("timeout", self, "delete")

func _physics_process(delta):
	col = move_and_collide(dir * bulSpeed * delta)
	
	if col:
		if col.collider.is_in_group("environment"):
			par.startDeathTimer()
			explode(col.position)
			self.queue_free()
		elif col.collider.is_in_group("enemy"):
			col.collider.correctPos()
			par.startDeathTimer()
			explode(col.position)
			col.collider.takeDamage(damage)
			self.queue_free()
	
	par.global_position = self.global_position

func explode(pos):
	var expl = explosion.instance()
	$"/root/Game".add_child(expl)
	expl.global_position = pos

func delete():
	self.queue_free()