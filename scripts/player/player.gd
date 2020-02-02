extends KinematicBody2D

onready var animSprite = $"AnimatedSprite"
onready var collider = $"CollisionShape2D"
onready var weapon = $"Arm/Weapon"
onready var arm = $"Arm"
onready var shootPos = $"Arm/Weapon/ShootPos"
onready var camera = $"Camera2D"
onready var shotGunSound = $"Sounds/Shotgun"
onready var rifleSound = $"Sounds/Rifle"
onready var swapSound = $"Sounds/Swap"

const FLOOR_NORMAL = Vector2(0, -1)

var GRAVITY = 10
var movSpeed = 100
var jumpForce = 250

var shootDelay
export(PackedScene) var rifleAmmo
export(PackedScene) var shotgunAmmo
export(PackedScene) var rifleFlash
export(PackedScene) var shotgunFlash
export(Texture) var rifleSprite
export(Texture) var shotgunSprite

var mov = Vector2()
var canShoot = true
var canJump = false
var currWeapon = WEAPON.rifle

enum WEAPON {
	rifle,
	shotgun
}

var shotgun = {
	damage = 1,
	shootDelay = 0.5,
	bulSpeed = 500,
	shootAngle = 0.03*PI,
	pellets = 7
}

var rifle = {
	damage = 2,
	shootDelay = 0.2,
	bulSpeed = 1000,
	shootAngle = 0.005*PI
}

func _ready():
	match currWeapon:
		WEAPON.rifle:
			self.shootDelay = rifle.shootDelay
		WEAPON.shotgun:
			self.shootDelay = shotgun.shootDelay

func _physics_process(delta):
	calcMov()
	calcArm()
	
	if Input.is_action_pressed("shoot") && canShoot:
		shoot()
		canShoot = false
		yield(get_tree().create_timer(shootDelay), "timeout")
		canShoot = true
		
	if Input.is_action_just_pressed("secondary"):
		swapWeapon()
	
	
### OWN FUNCTIONS ###

func calcMov():
	
	mov.y += GRAVITY
	
	if Input.is_action_pressed("right"):
		mov.x = movSpeed
		animSprite.play("walk")
		animSprite.flip_h = false
		
	elif Input.is_action_pressed("left"):
		mov.x = -movSpeed
		animSprite.play("walk")
		animSprite.flip_h = true
	else:
		mov.x = 0
		animSprite.play("idle")
		
	if Input.is_action_just_pressed("jump") && canJump:
		canJump = false
		mov.y = -jumpForce
		
	if !is_on_floor():
		if mov.y < 0:
			animSprite.play("jump")
		if mov.y > 0:
			animSprite.play("fall")
	else:
		canJump = true
	
	mov = move_and_slide(mov, FLOOR_NORMAL)
	
func calcArm():
	arm.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < self.global_position.x:
		weapon.flip_v = true
	else:
		weapon.flip_v = false

func swapWeapon():
	match currWeapon:
		WEAPON.rifle:
			#SHOTGUN
			currWeapon = WEAPON.shotgun
			weapon.texture = shotgunSprite
			self.shootDelay = shotgun.shootDelay
		WEAPON.shotgun:
			#RIFLE
			currWeapon = WEAPON.rifle
			weapon.texture = rifleSprite
			self.shootDelay = rifle.shootDelay
	swapSound.play(0)

func shoot():
	match currWeapon:
		WEAPON.rifle:
			#muzzleflash
			var flash = rifleFlash.instance()
			$"/root/Game".add_child(flash)
			flash.global_position = shootPos.global_position
			#bullet
			var bul = rifleAmmo.instance()
			$"/root/Game".add_child(bul)
			bul.global_position = shootPos.global_position
			bul.damage = rifle.damage
			bul.bulSpeed = rifle.bulSpeed
			
			bul.dir = randomVectorRotation(rifle.shootAngle, (get_global_mouse_position() - self.global_position).normalized())
			
			bul.look_at(get_global_mouse_position())
			rifleSound.play(0)
			camera.screenShake(1)
			
		WEAPON.shotgun:
			#muzzleflash
			var flash = shotgunFlash.instance()
			$"/root/Game".add_child(flash)
			flash.global_position = shootPos.global_position
			for i in range(0, shotgun.pellets):
				var bul = shotgunAmmo.instance()
				$"/root/Game".add_child(bul)
				bul.global_position = shootPos.global_position
				bul.damage = shotgun.damage
				bul.bulSpeed = shotgun.bulSpeed
				
				bul.dir = randomVectorRotation(shotgun.shootAngle, (get_global_mouse_position() - self.global_position).normalized())
				
				bul.look_at(get_global_mouse_position())
			shotGunSound.play(0)
			camera.screenShake(2)

func knockback():
	if global_position.x < get_global_mouse_position().x:
		translate(Vector2(-1, 0))
		print("knock")
	else:
		translate(Vector2(1, 0))

func randomVectorRotation(a, v):
	var angle = rand_range(-a, a)
	return Vector2(cos(angle)*v.x - sin(angle)*v.y, sin(angle)*v.x + cos(angle)*v.y)
