extends Node2D

@onready var game_vars = get_node("/root/Vars")

var win_cond;
var num_dest = 0;
var fired;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30

func level_over():
	
	game_vars.next_level()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	for b in [$billboard, $billboard2]:
		if $stand.destroyed == true:
			b.left = true
			b.destination = get_viewport().size[1]/2-400
		if $stand2.destroyed == true:
			b.right = true
			
	if num_dest == 2 and fired != true:
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		fired = true
		
	if win_cond == true:
		$castro.position.x -= 10
		
func _input(event):
	if event.is_action_pressed("left_click") and win_cond != false:
		for s in [$stand, $stand2]:
			if s.entered == true:
				if s.destroyed != true:
					s.destroyed = true
					num_dest += 1
				

func _on_lv_timer_timeout():
	win_cond = false
	

func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	print("here")
	level_over()


func _on_bartime_timeout():
	if win_cond != true or false:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
