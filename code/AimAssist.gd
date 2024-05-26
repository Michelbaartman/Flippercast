extends Node

@export var originLeftObj : Node2D
@export var originRightObj : Node2D

@export var targetObj : Node2D
@export var targetObjOffset : Node2D

@export var lineLeftObj : Line2D
@export var lineRightObj : Line2D

@export var playerObject : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	lineLeftObj.points[0] = originLeftObj.position
	lineRightObj.points[0] = originRightObj.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var stepLeft = ( (targetObj.position + targetObjOffset.position) - originLeftObj.position)
	var stepRight = ( (targetObj.position + targetObjOffset.position) - originRightObj.position)
	
	lineLeftObj.points[1] = lineLeftObj.points[0] + stepLeft
	lineLeftObj.points[2] = lineLeftObj.points[1] + stepLeft
	
	lineRightObj.points[1] = lineRightObj.points[0] + stepRight
	lineRightObj.points[2] = lineRightObj.points[1] + stepRight

	if playerObject.touchingLeftFlipper && !lineLeftObj.visible:
		lineLeftObj.visible = true
	elif !playerObject.touchingLeftFlipper && lineLeftObj.visible:
		lineLeftObj.visible = false

	if playerObject.touchingRightFlipper && !lineRightObj.visible:
		lineRightObj.visible = true
	elif !playerObject.touchingRightFlipper && lineRightObj.visible:
		lineRightObj.visible = false
