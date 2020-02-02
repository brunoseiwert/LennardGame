extends KinematicBody2D

signal dead
signal hit

const FLOOR_NORMAL = Vector2(0, -1)

export(String) var ACTOR_VARIABLES = "========"
export(float) var maxHealth
var health
var dead = false

#do not override
func _enter_tree():
	self.health = self.maxHealth

func takeDamage(amt):
	self.health -= amt
	if self.health <= 0:
		deathEffect()
		emit_signal("dead")
		die()
	damageEffect()
	emit_signal("hit")

#use for custom damage effect
func damageEffect():
	pass

#use for effect, when actor dies
func deathEffect():
	pass

#what to do when dead
func die():
	print("ded")