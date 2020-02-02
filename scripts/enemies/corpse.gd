extends AnimatedSprite

func _ready():
	self.modulate = Color(0.6, 0.6, 0.6, 1)
	play("death")
