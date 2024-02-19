extends Node

var mission_list = ["res://levels/duck_mission.tscn",
	"res://levels/cigar_mission.tscn",
	"res://levels/shots_mission.tscn"
	]
	
var main_menu = "res://levels/main.tscn"

var cur_level = 0
var score = 0

func next_level():
	cur_level += 1
	get_tree().change_scene_to_file(mission_list[cur_level])


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
