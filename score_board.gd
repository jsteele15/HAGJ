extends Node2D

@onready var game_vars = get_node("/root/Vars")

@onready var test_num = game_vars.score
var test_string;
var max = 0;
@onready var list_nums = [$Num7, $Num6, $Num5, $Num4, $Num3, $Num2, $Num]
var list_pos = [-800, -700, -600, -500, -400, -300, -200, -100]

# Called when the node enters the scene tree for the first time.
func _ready():
	test_string = str(test_num)
	for i in range(len(test_string)-1, -1, -1):
		
		list_nums[i].visible = true
		list_nums[i].position.x = list_pos[i]
		list_nums[i].frame = int(test_string[i])
		max += 1 
	$back.position.x -= list_pos[0] -100
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func change():
	test_num = game_vars.score
	test_string = str(test_num)
	
	for i in range(len(test_string)-1, -1, -1):
		
		if list_nums[i].visible != true:
			list_nums[i].visible = true
		list_nums[i].position.x = list_pos[i]
		list_nums[i].frame = int(test_string[i])
		
func _process(delta):
	pass
	#test_num = game_vars.score
	#test_string = str(test_num)
	#print(game_vars.score)
	#for i in range(len(test_string)-1, -1, -1):
		
#		list_nums[i].visible = true
#		list_nums[i].position.x -= list_pos[i]
#		list_nums[i].frame = int(test_string[i])
		
	
