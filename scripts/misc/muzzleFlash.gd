extends Sprite

func _ready():
	self.rotation_degrees = rand_range(0, 45)
	yield(get_tree().create_timer(0.02), "timeout")
	self.queue_free()
