extends RigidBody2D

var health = 100
@export var flipSpeed : float
@export var healthBarObj : Polygon2D
@export var auraObj : Area2D

@export var leftFlipperObj : AnimatableBody2D
@export var rightFlipperObj : AnimatableBody2D

var touchingLeftFlipper = false
var touchingRightFlipper = false

var invincible = false
var invincibleTime = 1
var invincibleTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	#health -= 3 * delta
	update_health()
	flipper_detection()
	if invincible:
		invincibleTimer -= delta
		#print(invincibleTimer)
		if invincibleTimer <= 0:
			invincible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info != null:
		var body = collision_info.get_collider()
		#print(body.name)
		if body in EnemyManager.enemyList:
			body.take_hit(25)
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#print(event)
		if touchingRightFlipper or touchingLeftFlipper:
			apply_impulse(Vector2(0, flipSpeed*-1), Vector2.ZERO)
		#apply_force(Vector2(0, flipSpeed), Vector2.ZERO)

func update_health():
	if healthBarObj.scale.x >= 0:
		healthBarObj.scale.x = 1.0 * ( health / 100.0 )

func flipper_detection():
	var bodies = auraObj.get_overlapping_bodies()
		#print(body.name)
	if leftFlipperObj in bodies:
		#print("left")
		touchingLeftFlipper = true
	else:
		touchingLeftFlipper = false

	if rightFlipperObj in bodies:
		#print("right")
		touchingRightFlipper = true
	else:
		touchingRightFlipper = false

func take_hit(damageValue, hitValue, body):
	if !invincible:
		#print("hit by: " + body.name)
		health -= damageValue
		apply_impulse(Vector2(0, hitValue *-1), position)
		invincibleTimer = invincibleTime
		invincible = true
