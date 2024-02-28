extends Node2D

@onready var game_vars = get_node("/root/Vars")

var start_entered;
var exit_entered;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.position.y = get_viewport().size[1]/2-50
	$TextSheet.position.y = get_viewport().size[1] - get_viewport().size[1] -100
	$MenuButtonsSheet.position.y = get_viewport().size[1] - get_viewport().size[1] -100
	$TextSheet2.position.y = get_viewport().size[1] - get_viewport().size[1] +100
	$MenuButtonsSheet2.position.y = get_viewport().size[1] - get_viewport().size[1] +100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for o in [$Head, $CiaHead, $CubanFlag, $UsFlag, $Bomb, $Beer]:
		o.rotation_degrees += 3
	
	$CubanFlag.position.x += 5
	$UsFlag.position.x -= 5
	$Bomb.position.y -= 5
	$Bomb.position.x += 5
	$Beer.position.y += 5
	$Beer.position.x -= 7

	
	

func _input(event):
	if event.is_action_pressed("left_click"):
		if start_entered == true:
			get_tree().change_scene_to_file(game_vars.help_screen)
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

