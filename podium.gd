extends Node2D

var entered;
var stolen;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stolen == true:
		$Podium.frame = 1


func _on_area_2d_mouse_entered():
	entered = true


func _on_area_2d_mouse_exited():
	entered = true
