extends Node

@onready var music_player = get_node("/root/MusicPlayer")

var mission_list = ["res://levels/duck_mission.tscn",
	"res://levels/cigar_mission.tscn",
	"res://levels/shots_mission.tscn",
	"res://levels/bay_pigs_mission.tscn",
	"res://levels/piano_mission.tscn",
	"res://levels/paint_wall_mission.tscn",
	"res://levels/podium_mission.tscn",
	"res://levels/shell_mission.tscn",
	"res://levels/baseball_mission.tscn"
	
	]
#"res://levels/dog_mission.tscn"
var inbetween = "res://levels/speeding_up.tscn"

var main_menu = "res://levels/main.tscn"

# Prints a random integer between -10 and 10.
var random = RandomNumberGenerator.new()
var nl;
var n;
var cur_level = 0
var cur_div = 1
var score = 0
var score_multi = 1
var cur_speed = 0
var speeds = [5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5]
var speed_times = [5, 6, 7, 7.5, 8, 9.5, 12, 17]
var saved;

func reset():
	cur_level = 0
	cur_div = 1
	score = 0
	score_multi = 1
	cur_speed = 0
	
func change_speed(lvTimer):
	lvTimer.wait_time = speeds[cur_speed]
	lvTimer.start()

###this stops timers and changes the score
func change_score_and_timers(lvTimer, winTimer, scoreb):
	lvTimer.stop()
	winTimer.start()
	score += 100 * score_multi
	score_multi += 1
	scoreb.change()

func rand_num_gen():
	random.randomize()
	n = random.randi_range(0, len(mission_list)-1)
	if n == saved:
		return rand_num_gen()
	else:
		saved = n
		return n
	
func next_level():
	cur_level += 1

	if cur_level/cur_div == 4 and cur_speed < len(speeds)-1:
		get_tree().change_scene_to_file(inbetween)
		cur_div += 1
		cur_speed += 1
	else:
		nl = rand_num_gen()
		
		get_tree().change_scene_to_file(mission_list[nl])
		
	

func lab_move(win_cond, label):
	if win_cond == false:
		if label.position.y > -20:
			label.position.y -= 5
			

func _input(event):
	if event.is_action_pressed("exc"):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
