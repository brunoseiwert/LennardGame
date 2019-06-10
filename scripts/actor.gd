extends KinematicBody2D

signal dead
signal hit

const FLOOR_NORMAL = Vector2(0, -1)

export(String) var ACTOR_VARIABLES = "========"
export(float) var maxHealth
var health

#do not override
func _enter_tree():
	self.health = self.maxHealth

func takeDamage(amt):
	self.health -= amt
	damageEffect()
	if self.health <= 0:
		self.health = 0
		emit_signal("dead")
		die()
	emit_signal("hit")

#use for custom damage effect
func damageEffect():
	pass

#what to do when dead
func die():
	print("ded")