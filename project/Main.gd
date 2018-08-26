extends Node

# Is there a datetime in Godot?
var day
var hour
var minute

func _ready():
	# setup keypress
	set_process_input(true)
	# initialise HUD
	day = 0
	hour = 5
	minute = 59
	refreshHUD()
	intro()
	pass

func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_released("ui_accept"): # Space or enter
		stopAlarm()
	
func intro():
	# Play intro music
	addMinute()
	# Play alarm to interrupt
	startAlarm()

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

func startAlarm():
	$HUD/Label.add_color_override("font_color", Color("23eb07"))
	pass

func stopAlarm():
	#reset to green hex colour
	$HUD/Label.add_color_override("font_color", Color(255,0,0,1))
	refreshHUD()
	# This is how you switch levels
	#get_tree().change_scene("Level1.tscn")
	
func refreshHUD():
	$HUD/Label.set_text("Day " + str(day) + " " + paddedTo2Digits(hour) + ":" + paddedTo2Digits(minute))
	
func paddedTo2Digits(time):
	var padded
	if (time < 10):
		padded = "0" + str(time)
	else:
		padded = str(time)
	return padded