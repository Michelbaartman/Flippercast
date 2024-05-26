extends Area2D

@export var playerObj : CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	death_zone_check()

func death_zone_check():
	var bodies = get_overlapping_bodies()
	#print(bodies)
	if playerObj in bodies:
		playerObj.take_hit(25, 100, position)
