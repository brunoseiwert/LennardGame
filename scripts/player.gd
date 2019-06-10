extends "res://scripts/actor.gd"

onready var animSprite = $"AnimatedSprite"

var mov = Vector2()

func _physics_process(delta):
	mov.y += 5
	
	if Input.is_action_pressed("right"):
		mov.x = 50
		animSprite.play("walk")
		animSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		mov.x = -50
		animSprite.play("walk")
		animSprite.flip_h = true
	else:
		mov.x = 0
		animSprite.play("idle")
		
	if Input.is_action_just_pressed("jump"):
		mov.y = -200
		
	if !is_on_floor():
		if mov.y < 10:
			animSprite.play("jump")
		if mov.y > 100:
			animSprite.play("fall")
		
	mov = move_and_slide(mov, FLOOR_NORMAL)