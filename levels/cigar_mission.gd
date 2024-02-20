extends Node2D

@onready var game_vars = get_node("/root/Vars")
var win_cond;

# Called when the node enters the scene tree for the first time.
func _ready():
	$time_rect.position.y = get_viewport().size[1]/2-30

func level_over():
	game_vars.next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	#need to get the hit done properly
	if win_cond == true:
		$LeftHand.rotation += 1
		$LeftHand.position.y += 10
	
	if win_cond != true:
		$LeftHand.position.x -= 2
	
func _input(event):
	if event.is_action_pressed("left_click") and $LeftHand.entered == true:
		print("mnksdbgou")
		win_cond = true
		$lvTimer.stop()
		$winTimer.start()
		
		
		#


func _on_lv_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()

func _on_win_timer_timeout():
	win_cond = false


func _on_bartime_timeout():
	if win_cond != true or false:
		$time_rect.size.x -= 5
