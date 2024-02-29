extends Node2D

@onready var game_vars = get_node("/root/Vars")
var random = RandomNumberGenerator.new()
var win_cond;
var fired;
var sound_fired;
var rand_num;
var start_loc = [[-360, -347], [100, -376], [700, -315], [300, -87]]

var chosen;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30
	$level_text.position.y = get_viewport().size[1]/2-30-100
	random.randomize()
	
	rand_num = random.randi_range(0, 3)

	$bomb.position.x = start_loc[rand_num][0]
	$bomb.position.y = start_loc[rand_num][1]
	

func level_over():
	game_vars.next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond != null:
		$level_text.visible = false
	
	for i in [[$shells, 0], [$shells2, 1], [$shells3, 2], [$shells4, 3]]:
		if i[1] == rand_num:
			i[0].explosive = 1
			if i[0].collected == true and fired != true:
				win_cond = false
				fired = true
				i[0].position.y -= 20
				i[0].position.x -= 20
				i[0].rotation_degrees += 5
		else:
			i[0].explosive = 0
		
	
	if win_cond == true and fired != true:
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		fired = true
		
	if win_cond == false:
		game_vars.music_player.turn_down()
		$bomb.position.y -= 10
		$bomb.rotation_degrees += 5
		$bomb/fire.emitting = false
		if sound_fired == null:
			$AudioStreamPlayer2D.play()
			$explosion.emitting = true
			sound_fired = true
		
		#if $shells4.collected != true:
			#$shells4.position.y -= 20
			#$shells4.position.x -= 20
			#$shells4.rotation_degrees += 5
			

	

func _input(event):
	if event.is_action_pressed("left_click") and win_cond == null:
		for s in [$shells, $shells2, $shells3, $shells4]:
			if s.entered == true and s.visible == true:
				s.collected = true
				if s.explosive != 1:
					win_cond = true


func _on_lv_timer_timeout():
	win_cond = false

func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()

func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
		
