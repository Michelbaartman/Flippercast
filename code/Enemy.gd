extends AnimatableBody2D

var health = 100
@export var healthBarObj : Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	EnemyManager.enemyList.append(self)
	#print(EnemyManager.enemyList)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_health()
	pass

func update_health():
	if healthBarObj.scale.x >= 0:
		healthBarObj.scale.x = 1.0 * ( health / 100.0 )

func take_hit(damage):
	print("hit")
	health -= damage
