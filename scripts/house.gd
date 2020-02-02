extends Area2D
signal game_over

export(Material) var hitEffectMaterial
export(Material) var normalMaterial

onready var healthBar = $"/root/Game/UiLayer/HealthBar"

export(int) var health = 10

func _ready():
	pass


func _on_House_body_entered(body):
	if body.is_in_group("enemy"):
		damageEffect()
		reduceHealth(body.damage)
		body.execute()

func damageEffect():
	$"Hit".play(0)
	self.material = hitEffectMaterial
	yield(get_tree().create_timer(0.1), "timeout")
	self.material = normalMaterial

func reduceHealth(amt):
	health -= amt
	healthBar.setValue(health)
	if health <= 0:
		$"Dead".play(0)
		emit_signal("game_over")