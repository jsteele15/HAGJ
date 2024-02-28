extends Node2D

@onready var game_vars = get_node("/root/Vars")

var duck_drop = false
var fired = false
var win_cond;
var fired2;

# Called when the node enters the scene tree for the first time.
func _ready():
	game_vars.change_speed($lvTimer)
	
	$time_rect.position.y = get_viewport().size[1]/2-30
	print(get_viewport().size[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond != null:
		
		$trees3.visible = false
		$trees.rotation_degrees += 0.5
		$trees.position.x += 1
		$trees.position.y += 1
		if fired2 == null:
			$level_text.visible = false
			#might add gun shot later
			$AudioStreamPlayer2D.play()
			fired2 = true
			
	
	if win_cond == false:
		
		
		$castro.position.y += 10
		$castro.rotation += 0.02
		$blood_wall.emitting = true
	
	
		
	if duck_drop == false:
		
		$duck.position.x = get_global_mouse_position()[0]
		$duck.position.y = get_global_mouse_position()[1]
	if duck_drop == true and fired == false:
		$explosion.emitting = true
		if $duck.position.x > $castro.position.x:
			#eventually this will be an animation, but right now it just moves castros head by 200 px
			#depending on where the duck gets dropped
			$castro.position.x += 200
			$duck.set_dir("right")
			fired = true
		else:
			$castro.position.x -= 200
			$duck.set_dir("left")
			fired = true
	if win_cond == false:
		game_vars.music_player.turn_down()
		
	
	if duck_drop == true and $duck.position.y <= 260:
		$duck.position.y += 10
		
	if duck_drop == true and $duck.position.y <= 270 and $duck.position.x <= 0:
		$duck.position.x -= 5
		$castro.position.x -= 5
		
	if duck_drop == true and $duck.position.y <= 270 and $duck.position.x > 0:
		$duck.position.x += 5
		$castro.position.x += 5
	

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
