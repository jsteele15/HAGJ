extends Node2D

@onready var game_vars = get_node("/root/Vars")

var entered;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	if event.is_action_pressed("left_click"):
		if entered == true:
			game_vars.music_player.return_vol()
			game_vars.reset()
			game_vars.next_level()

func _on_area_2d_mouse_entered():
	$rest.frame = 4
	entered = true


func _on_area_2d_mouse_exited():
	$rest.frame = 5
	entered = false
