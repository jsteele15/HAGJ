extends Node2D

@onready var game_vars = get_node("/root/Vars")

var duck_drop = false
var fired = false
var win_cond;


# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	
	$time_rect.position.y = get_viewport().size[1]/2-30
	print(get_viewport().size[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond == false:
		
		$castro.position.y += 10
		$castro.rotation += 0.02
		$blood_wall.emitting = true
		
	if duck_drop == false:
		
		$duck.position.x = get_global_mouse_position()[0]
		$duck.position.y = get_global_mouse_position()[1]
	if duck_drop == true and fired == false:
		
		if $duck.position.x > $castro.position.x:
			#eventually this will be an animation, but right now it just moves castros head by 200 px
			#depending on where the duck gets dropped
			$castro.position.x += 200
			fired = true
		else:
			$castro.position.x -= 200
			fired = true
	if win_cond == false:
		game_vars.music_player.turn_down()

func _input(event):
	if event.is_action_pressed("left_click") and win_cond == null:
		$duck.visible= true
		duck_drop = true#
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		
func _on_lv_timer_timeout():
	win_cond = false
	
	
func _on_win_timer_timeout():
	game_vars.next_level()


func _on_bartime_timeout():
	if win_cond != true or false:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
