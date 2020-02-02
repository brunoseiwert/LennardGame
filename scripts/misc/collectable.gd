extends KinematicBody2D

const floornormal = Vector2(0, -1)

export(int) var points = 1
export(int) var vImpulse
export(int) var hImpulse

var mov = Vector2()
var collected = false

func _ready():
	mov = Vector2(rand_range(-hImpulse, hImpulse), -vImpulse)

func _physics_process(delta):
	mov.y += 3
	
	if is_on_floor():
		mov.x = 0
	
	mov = move_and_slide(mov, floornormal)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if !collected:
			$"Sprite".visible = false
			$"Sounds/Collect".play(0)
			$"/root/Game".increaseScore(points)
		collected = true


func _on_Sound_finished():
	self.queue_free()
