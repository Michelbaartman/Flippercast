extends Node2D

var flipped = false;
var neutralRot = 0;
var flipRot = -25;
var spacePressed = false

@export var mirror = false
@export var rightFlipper : AnimatableBody2D
@export var leftFlipper : AnimatableBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flipped:
		if leftFlipper.rotation_degrees >= flipRot:
			leftFlipper.rotation_degrees += (flipRot + leftFlipper.rotation_degrees) * 0.8

			rightFlipper.rotation_degrees += ((flipRot * -1) + rightFlipper.rotation_degrees) * 0.8
		
		if !spacePressed:
			flipped = false;
			leftFlipper.rotation_degrees = neutralRot
			rightFlipper.rotation_degrees = neutralRot
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#print(event)
		#velocity.y = flipPower
		if !flipped:
			leftFlipper.rotation_degrees = flipRot * 0.6
			rightFlipper.rotation_degrees = (flipRot*-1) * 0.6
		flipped = true
		spacePressed = true
	
	if event.is_action_released("ui_accept"):
		spacePressed = false
