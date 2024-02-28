extends Node2D

@onready var game_vars = get_node("/root/Vars")
var entered;
var reached_dest;
var alive = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reached_dest != true and alive == true:
		if game_vars.cur_speed != 0:
			$".".position.x += 1 + game_vars.cur_speed
		else:
			$".".position.x += 2
	if alive == false:
		$Sprite2D.frame = 0
		print("dead")


func _on_area_2d_mouse_entered():
	entered = true;


func _on_area_2d_mouse_exited():
	entered = false;
