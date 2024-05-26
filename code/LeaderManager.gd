extends CharacterBody2D

var health = 100
@export var gravity : float
@export var momentumCorrection : float
@export var dashPower : float
@export var flipPower : float
@export var speed : float
@export var healthBarObj : Polygon2D
@export var auraObj : Area2D

@export var leftFlipperObj : AnimatableBody2D
@export var rightFlipperObj : AnimatableBody2D
var touchingLeftFlipper = false
var touchingRightFlipper = false
var inGutter = false
var inLeftSide = false
var inRightSide = false

@export var fieldLeftObj : Area2D
@export var fieldRightObj : Area2D

var invincible = false
var invincibleTime = 1
var invincibleTimer = 0

@export var nEnemyTether : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health -= 5 * delta
	update_health()
	collision_detection()
	enemy_distance_check()
	#print(get_real_velocity())
	#print(velocity)

	if invincible:
		invincibleTimer -= delta
		if invincibleTimer <= 0:
			invincible = false
	pass

func _physics_process(delta):
	if velocity.y <= gravity:
		velocity.y += gravity * ( delta * speed )
	if velocity.y <= gravity * -1:
		velocity.y += ( gravity * momentumCorrection )  * delta
	
	move_and_slide()

	# for i in get_slide_collision_count():
	# 	var collision = get_slide_collision(i)
	# 	velocity = velocity.bounce(collision.get_normal())
	# 	print("I collided with ", collision.get_collider().name)

	# var collision = move_and_collide(velocity * delta)
	# if collision:
	# 	var body = collision.get_collider()
	# 	if body != leftFlipperObj && body != rightFlipperObj:
	# 		velocity = velocity.bounce(collision.get_normal()) * 0.1
	# 	else:
	# 		velocity = velocity.bounce(collision.get_normal()) * 0.1
			


func _input(event):
	if touchingRightFlipper or touchingLeftFlipper:
		if event.is_action_pressed("ui_accept"):
			#print("flip")
			var newVelocity = get_real_velocity()
			newVelocity.y = flipPower * -1
			velocity = newVelocity
			pass
		if event.is_action_released("ui_accept"):
			if touchingLeftFlipper or touchingRightFlipper:
				velocity = get_real_velocity()
	elif !touchingLeftFlipper && !touchingRightFlipper:
		if event.is_action_pressed("ui_accept"):
			#print("dash")
			velocity.y = dashPower *-1
		pass

func enemy_distance_check():
	var myPos = position
	var closestEnemy
	var closestEnemyPos
	var closestEnemyDif

	# if EnemyManager.enemyList != null:
	# 	for enemy in EnemyManager.enemyList:
	# 		if closestEnemy == null:
	# 			enemy = closestEnemy
	# 			closestEnemyPos = enemy.get_parent().position
	# 			closestEnemyDif = myPos - closestEnemyPos
	# 		else:
	# 			var tPosDif = myPos - closestEnemy.get_parent().position
	# 			if (tPosDif.x + tPosDif.y) < (closestEnemyDif.x + closestEnemyDif.y):
	# 				closestEnemy = enemy
	# 				closestEnemyPos = closestEnemy.get_parent().position
	# 				closestEnemyDif = tPosDif
	

	# 	nEnemyTether.points[0] = myPos
	# 	nEnemyTether.points[1] = closestEnemyPos


func dash():
	
	pass

func collision_detection():
	var bodies = auraObj.get_overlapping_bodies()
	field_collision(bodies)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider in EnemyManager.enemyList:
			collider.take_hit(25)
			bounce(0.7)

func bounce(strength):
	velocity = (velocity * -1) * strength

func field_collision(bodies):
	if leftFlipperObj in bodies:
		touchingLeftFlipper = true
	else:
		touchingLeftFlipper = false

	if rightFlipperObj in bodies:
		touchingRightFlipper = true
	else:
		touchingRightFlipper = false

func update_health():
	if healthBarObj.scale.x >= 0:
		healthBarObj.scale.x = 1.0 * ( health / 100.0 )

func take_hit(damageValue, hitValue, body):
	if !invincible:
		#print("hit by: " + body.name)
		health -= damageValue
		velocity.y = -250
		velocity.x = 50
		invincibleTimer = invincibleTime
		invincible = true
