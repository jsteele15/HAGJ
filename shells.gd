extends Node2D

@export var ind = 0;
@export var explosive = 0;
var entered;
var collected;
var fired;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = ind


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collected == true:
		if explosive == 0:
			$".".visible = false
		if explosive == 1 and fired != true:
			$".".position.x -= 150
			$".".position.y -= 150
			fired = true


func _on_area_2d_mouse_entered():
	entered = true


func _on_area_2d_mouse_exited():
	entered = false
