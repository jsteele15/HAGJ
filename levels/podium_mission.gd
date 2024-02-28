extends Node2D

@onready var game_vars = get_node("/root/Vars")

var win_cond;
var fired;
var fired_music
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30

func level_over():
	game_vars.next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond != null:
		for h in [$CiaHead]:
			if h.position.x <= 0:
				h.position.x -= 2
	
	if $podium.stolen == null:
		if $castro.position.x >=  $podium.position.x:
			$castro.position.x -= 3
	
	if $podium.stolen != null:
		$level_text.visible = false
		$castro.position.x += 3
		
	
	if win_cond == true and fired != true:
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		fired = true
	
	if win_cond == false:
		game_vars.music_player.turn_down()
		$castro.position.y -= 10
		$castro.position.x += 10
		$castro.rotation += 0.04
		if fired_music == null:
			$podium.visible = false
			$fire.emitting = false
			$AudioStreamPlayer2D.play()
			$explosion.emitting = true
			fired_music = true
	
	
	
func _input(event):
	if event.is_action_pressed("left_click") and win_cond != false:
		if $podium.entered == true and $podium.stolen == null:
			$podium.stolen = true
			win_cond = true


func _on_lv_timer_timeout():
	win_cond = false


func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()
	

func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
