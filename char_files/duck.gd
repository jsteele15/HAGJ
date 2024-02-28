extends Node2D

var dir = "left";
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_dir(direction):
	dir = direction

func _on_timer_timeout():
	if dir == "left":
		if $DuckTemp.frame == 1:
			$DuckTemp.frame = 0
		else:
			$DuckTemp.frame = 1
			
	if dir == "right":
		if $DuckTemp.frame == 2:
			$DuckTemp.frame = 3
		else:
			$DuckTemp.frame = 2
