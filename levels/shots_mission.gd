extends Node2D

@onready var game_vars = get_node("/root/Vars")
var win_cond;
var fired;

# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	$Beerim.position.y = $beer.position.y
	$Beerim.position.x = $beer.position.x
	
	if $beer.position.x > 0 and $beer2.position.x < 0 and fired != true:
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		fired = true
		
	
	for b in [$beer, $beer2]:
		if b.entered == true and Input.is_mouse_button_pressed(1):
			if win_cond == null or win_cond == true:
				b.position.x = get_global_mouse_position()[0]
				b.position.y = get_global_mouse_position()[1]
			
	if $beer.entered == true and $beer2.entered == true and win_cond == null:
		win_cond = false
		$beer.rotation_degrees = 90
		$beer.position.x += 20
		$beer2.rotation_degrees = 90
		$Beerim.rotation_degrees = 90
		$Beerim.position.x += 20
		$beer2.position.x += 50
		$beer2/spill_sound.play()
		
	
	if win_cond == true:
		$cia.position.y += 10
		$cia.rotation += 0.02
	
	if win_cond == false:
		game_vars.music_player.turn_down()
		$Head.position.y += 10
		$Head.rotation += 0.02



func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()
	

func _on_lv_timer_timeout():
	win_cond = false
	
func level_over():
	game_vars.next_level()


func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
