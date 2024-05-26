extends Node2D

@export var attachTarget : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position != attachTarget.position:
		position = attachTarget.position
	pass
