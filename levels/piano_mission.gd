extends Node2D

@onready var game_vars = get_node("/root/Vars")

var win_cond;
var fired;
var crash;
var hook_chose;
# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	$time_rect.position.y = get_viewport().size[1]/2-30

func level_over():
	game_vars.next_level()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond == true and crash != true:
		$cia_rope.points[0].y -= 10
		$castro_rope.visible = false
		if fired != true:
			$top_rope.points[1].y = $piano.position.y
			fired = true
		if fired == true:
			if $piano.position.x <= $cia.position.x:
				$top_rope.points[1].y += 10
				$top_rope.points[1].x += 15
				$piano.position.y += 10
				$piano.position.x += 15
				print($piano.position.x, $cia.position.x)
				if $cia.position.x - $piano.position.x <= 20:
					$cia.position.x += 15
					$cia.rotation += 0.04
	
	if win_cond == false and crash != true and hook_chose != true:
		if $piano.position.y <= $castro.position.y - 50:
			$cia_rope.points[0].y -= 10
			$castro_rope.points[1].y += 10
			$piano.position.y += 10
			
		else:
			$blood_floor.emitting = true
	
	if win_cond == false and crash != true and hook_chose == true:
		
		if fired != true:
			print($top_rope.points[0].y)
			$cia_rope.points[1].x = $top_rope.points[1].x
			$top_rope.visible = false
			fired = true
		else:
			if $piano.position.y <= $castro.position.y - 50:
				$cia_rope.points[0].y -= 10
				$cia_rope.points[0].x -= 10
				$castro_rope.points[1].y += 10
				$piano.position.y += 10
		
	if $hook.visible == false and hook_chose != true:
		win_cond = true
		game_vars.change_score_and_timers($lvTimer, $winTimer, $score_board)
		hook_chose = true
		
	if $hook2.visible == false and hook_chose != true:
		win_cond = false 
		$lvTimer.stop()
		hook_chose = true
		
	if win_cond == false:
		if $castro.position.y - $piano.position.y <= 60:
			$blood_floor.emitting = true
		game_vars.music_player.turn_down()
		

func _input(event):
	if event.is_action_pressed("left_click") and win_cond != false:
		for h in [$hook, $hook2]:
			if h.entered == true:
				h.visible = false

func _on_lv_timer_timeout():
	win_cond = false


func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()


func _on_bartime_timeout():
	if win_cond == null:
		$time_rect.size.x -= game_vars.speed_times[game_vars.cur_speed]
