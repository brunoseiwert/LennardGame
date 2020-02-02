extends Camera2D

export(int) var shakeAmt
export(float) var shakeMag

onready var camOffset = self.offset
onready var origOffset = self.offset

func _physics_process(delta):
	
	camOffset = (get_global_mouse_position() - self.global_position) * 0.08
	camOffset.x = int(camOffset.x)
	camOffset.y = int(camOffset.y)
	#print(camOffset)
	
	self.offset = origOffset + camOffset

func screenShake(mag):
	for i in range(shakeAmt):
		var x = rand_range(-1, 1)
		var y = rand_range(-1, 1)
		self.offset = origOffset + camOffset + Vector2(x, y).normalized() * mag
		yield(get_tree().create_timer(0.02), "timeout")
	self.offset = origOffset + camOffset