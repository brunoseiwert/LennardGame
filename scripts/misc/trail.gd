extends Particles2D

func startDeathTimer():
	self.emitting = false
	$"DeathTimer".start()

func _on_DeathTimer_timeout():
	self.queue_free()
