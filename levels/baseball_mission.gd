extends Node2D

@onready var game_vars = get_node("/root/Vars")

var win_cond;
var fired;
var shoes_untied = 0
var fired_music;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30
	
func level_over():
	game_vars.next_level()

func changeUp():
	$shoe.visible = false
	$shoe2.visible = false
	for i in [$castro, $bomb, $Base, $Base2]:
		i.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if shoes_untied == 2 and fired == null:
		changeUp()
		
		fired = true
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
	
	if win_cond == true:
		if $castro.position.y <= $Base.position.y:
			$castro.position.y += 12
			$castro.position.x += 16
			$castro.rotation += 0.055
			
	if win_cond == false:
		changeUp()
		game_vars.music_player.turn_down()
		if $castro.position.x < $Base2.position.x:
			$castro.position.x += 16
		else:
			$bomb.position.y += 10
			$bomb.rotation += 0.04
			$castro.position.y -= 10
			$castro.rotation -= 0.04
			$Base2.position.y -= 5
			$Base2.position.x -= 10
			$Base2.rotation_degrees -= 5
			if fired_music == null:
				$explosion.emitting = true
				$bomb/fire.emitting = false
				$AudioStreamPlayer2D.play()
				fired_music = true
	
	

func _input(event):
	if event.is_action_pressed("left_click") and win_cond == null:
		for s in [$shoe, $shoe2]:
			if s.entered == true and s.untied != true:
				s.untied = true 
				shoes_untied += 1


func _on_lv_timer_timeout():
	win_cond = false

func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()

func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
		
