extends Node

# Is there a datetime in Godot?
var day
var hour
var minute
var streamPlayer

func _ready():
	# setup keypress
	set_process_input(true)
	# initialise HUD
	day = 0
	hour = 5
	minute = 59
	streamPlayer = AudioStreamPlayer.new()
	self.add_child(streamPlayer)
	streamPlayer.stream = load("res://assets/sleepin-bass.ogg")
	streamPlayer.play()
	refreshHUD()
	$Timer.start()

func _input(event):
	if Input.is_action_just_released("ui_accept"): # Space or enter
		stopAlarm()

func _on_Timer_timeout():
	addMinute()
	$Timer.stop()
	if (minute % 10 == 0):
		startAlarm()
	else:
		$Timer.start()

# TODO: This will need to be addMinutes(int minutesToAdd) eventually
func addMinute():
	minute = minute + 1
	# Add leftover minutes with modulo etc
	if (minute == 60):
		hour = hour + 1
		minute = 0
	if (hour == 24):
		day = day + 1
		hour = 0
	refreshHUD()

func startAlarm():
	$HUD/Label.add_color_override("font_color", Color(255,0,0,1))
	streamPlayer.stream = load("res://assets/ding.ogg")
	streamPlayer.play()
	pass

func stopAlarm():
	#reset to green hex colour
	$HUD/Label.add_color_override("font_color", Color("23eb07"))
	refreshHUD()
	streamPlayer.stop()
	$Timer.start()
	# This is how you switch levels
	#get_tree().change_scene("Level1.tscn")
	
func refreshHUD():
	var dayText = ""
	if (day > 0):
		dayText = "Day " + str(day) + " "
	$HUD/Label.set_text(dayText + paddedTo2Digits(hour) + ":" + paddedTo2Digits(minute))
	
func paddedTo2Digits(time):
	var padded
	if (time < 10):
		padded = "0" + str(time)
	else:
		padded = str(time)
	return padded
