extends Node2D

@onready var game_vars = get_node("/root/Vars")

var spin;
var head_spin;
var butt_enter;
var beer;
var hook;
var hand;
var head;


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuButtonsSheet.position.y = get_viewport().size[1]/2-50
	$behind_play.position.y = get_viewport().size[1]/2-50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for b in [$beer]:
		if b.entered == true and Input.is_mouse_button_pressed(1):
			b.position.x = get_global_mouse_position()[0]
			b.position.y = get_global_mouse_position()[1]
			beer = true
	
	if spin == true:
		$LeftHand.position.x -= 5
		$LeftHand.rotation_degrees -= 5
		hand = true
	if head_spin == true:
		$CiaHead.position.x += 5
		$CiaHead.rotation_degrees += 5
		head = true
	
	if beer == true and hook == true and hand == true and head == true:
		game_vars.next_level()

func _input(event):
	if event.is_action_pressed("left_click"):
		if $LeftHand.entered == true and $beer.entered != true:
			spin = true
		if butt_enter == true:
			game_vars.next_level()
		if $hook.entered == true:
			$hook.visible = false
			hook = true
		if $CiaHead.entered == true:
			head_spin = true


func _on_area_2_dstart_mouse_entered():
	butt_enter = true
	$MenuButtonsSheet.frame = 0


func _on_area_2_dstart_mouse_exited():
	butt_enter = false
	$MenuButtonsSheet.frame = 1

