extends Node2D

@export var tx = 0;
@export var level: Node2D;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = tx


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level.win_cond != null:
		$".".position.x -= 20
		$".".position.y += 10
		$".".scale.x -= 0.02
		$".".scale.y -= 0.02
		
