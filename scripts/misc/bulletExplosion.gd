extends AnimatedSprite

func _ready():
	self.rotation = rand_range(0, 46)
	play("explosion")

func _on_AnimatedSprite_animation_finished():
	self.queue_free()


func _on_AnimatedSprite_frame_changed():
	#self.rotation = rand_range(0, 46)
	pass
