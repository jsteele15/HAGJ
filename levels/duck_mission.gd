extends Node2D

@onready var game_vars = get_node("/root/Vars")

var duck_drop = false
var fired = false
var win_cond;

# Called when the node enters the scene tree for the first time.
func _ready():
	$time_rect.position.y = get_viewport().size[1]/2-30
	print(get_viewport().size[1])
	(game_vars.score)


func level_over():
	game_vars.next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if win_cond == false:
		$castro.position.y += 10
		
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

func _input(event):
	if event.is_action_pressed("left_click") and win_cond != false:
		$duck.visible= true
		duck_drop = true#
		win_cond = true
		$lvTimer.stop()
		$winTimer.start()
		
func _on_lv_timer_timeout():
	win_cond = false
	
	
func _on_win_timer_timeout():
	print("next level")
	game_vars.score += 100 * game_vars.cur_level
	level_over()


func _on_bartime_timeout():
	if win_cond != true or false:
		$time_rect.size.x -= 5
