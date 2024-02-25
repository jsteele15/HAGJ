extends Node2D

@onready var game_vars = get_node("/root/Vars")

var start_entered;
var exit_entered;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("left_click"):
		if start_entered == true:
			game_vars.next_level()
		if exit_entered == true:
			get_tree().quit()


func _on_area_2_dstart_mouse_entered():
	$MenuButtonsSheet.frame = 0
	start_entered = true

func _on_area_2_dstart_mouse_exited():
	$MenuButtonsSheet.frame = 1
	start_entered = false

func _on_area_2_dexit_mouse_entered():
	$MenuButtonsSheet2.frame = 2
	exit_entered = true

func _on_area_2_dexit_mouse_exited():
	$MenuButtonsSheet2.frame =3
	exit_entered = false
