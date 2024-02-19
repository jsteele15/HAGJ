extends Node2D

@onready var game_vars = get_node("/root/Vars")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(game_vars.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
