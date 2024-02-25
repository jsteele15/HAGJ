extends Node

func _ready():
	play_music()

func play_music():
	$AudioStreamPlayer.play()
	$Timer.start()

func turn_down():
	$AudioStreamPlayer.volume_db -= 0.1
	
func return_vol():
	$AudioStreamPlayer.volume_db = 0

func _on_timer_timeout():
	$AudioStreamPlayer.play()
