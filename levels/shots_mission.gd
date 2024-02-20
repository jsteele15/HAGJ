extends Node2D

@onready var game_vars = get_node("/root/Vars")
var win_cond;
var fired;

# Called when the node enters the scene tree for the first time.
func _ready():
	$time_rect.position.y = get_viewport().size[1]/2-30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_vars.lab_move(win_cond, $"lose label")
	
	if $beer.position.x > 0 and $beer2.position.x < 0 and fired != true:
		win_cond = true
		$winTimer.start()
		$lvTimer.stop()
		fired = true
		
	
	for b in [$beer, $beer2]:
		if b.entered == true and Input.is_mouse_button_pressed(1):
			b.position.x = get_global_mouse_position()[0]
			b.position.y = get_global_mouse_position()[1]
			
	if $beer.entered == true and $beer2.entered == true:
		win_cond = false
		



func _on_win_timer_timeout():
	game_vars.score += 100 * game_vars.cur_level
	level_over()
	

func _on_lv_timer_timeout():
	win_cond = false
	
func level_over():
	game_vars.next_level()


func _on_bartime_timeout():
	if win_cond != true or false:
		$time_rect.size.x -= 5
