extends Node2D

@export var fra = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Trees.frame = fra


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
