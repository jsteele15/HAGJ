extends Node2D

@export var bill = 0
var destination = 6200;
var left;
var right;
var right_fired;
var left_fired;

# Called when the node enters the scene tree for the first time.
func _ready():
	$TempBillboard.frame = bill


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if right == true and right_fired != true:
		$".".rotation -= 12.5
		$".".position.y += 12
		right_fired = true
	
	if left == true and left_fired != true:
		$".".rotation += 12.5
		$".".position.y += 12
		left_fired = true
	#print($".".position.y)
	if left == true and right == true:
		if $".".position.y <= destination:
			$".".position.y += 3
		
