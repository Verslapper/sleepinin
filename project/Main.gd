extends Node

# Is there a datetime in Godot?
var day
var hour
var minute

func _ready():
	# setup keypress?
	# initialise HUD
	day = 0
	hour = 6
	minute = 0
	intro()
	pass

func _process(delta):
	if Input.is_action_pressed("ui_accept"): # Space or enter
		stopAlarm()
	
func intro():
	# Play intro music
	# Play alarm to interrupt
	startAlarm()

func startAlarm():
	pass

func stopAlarm():
	minute = minute + 1
	refreshHUD()
	
func refreshHUD():
	$HUD/Label.set_text("Day " + str(day) + " " + paddedTo2Digits(hour) + ":" + paddedTo2Digits(minute))
	
func paddedTo2Digits(time):
	var padded
	if (time < 10):
		padded = "0" + str(time)
	else:
		padded = str(time)
	return padded