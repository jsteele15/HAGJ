extends Node2D

@onready var game_vars = get_node("/root/Vars")
var dead_ships = 0

var win_cond;
var fired;

func level_over():
	game_vars.next_level()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	for s in [$ship, $ship2, $ship3]:
		if s.reached_dest == true and s.alive == true:
			$land.position.x -= 1
			
	if dead_ships == 3 and fired != true:
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		fired = true
		
	
func _input(event):
	if event.is_action_pressed("left_click") and win_cond != false:
		print("input")
		for s in [$ship, $ship2, $ship3]:
			if s.entered == true and s.alive == true:
				print("hfudisf")
				dead_ships += 1
				s.alive = false
				s/fire.emitting = true


###when the lv timer times out, it starts automatically, the level ends in failure
func _on_lv_timer_timeout():
	for s in [$ship, $ship2, $ship3]:
		s.reached_dest = true
	win_cond = false


func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()


func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
