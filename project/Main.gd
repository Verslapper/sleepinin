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
	#streamPlayer.stream = load("res://assets/sleepin-bass.ogg")
	#streamPlayer.play()
	refreshHUD()
	$Timer.start()

func _input(event):
	if Input.is_action_just_released("ui_accept"): # Space or enter
		stopAlarm()
		$Timer.start()
	if Input.is_action_just_released("ui_cancel"): # Escape
		stopAlarm()
		sleep()

func _on_Timer_timeout():
	addMinute()
	$Timer.stop()
	if (minute % 10 == 0):
		startAlarm()
	else:
		$Timer.start()

func addMinute():
	minute = minute + 1
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

func stopAlarm():
	#reset to green hex colour
	$HUD/Label.add_color_override("font_color", Color("23eb07"))
	refreshHUD()
	streamPlayer.stop()
	# This is how you switch levels
	#get_tree().change_scene("Level1.tscn")

func sleep():
	if (day == 0 && hour <= 6):
		$HUD/PlotLabel.set_text("To: S.Bossman; Stuck in traffic, be there soon.")
	elif (day == 0):
		$HUD/PlotLabel.set_text("To: S.Bossman; Slept through my alarm, be there soon.")
	else:
		$HUD/PlotLabel.set_text("From: S.Bossman; Don't bother coming in tomorrow.")
	
func refreshHUD():
	var dayText = ""
	if (day > 0):
		dayText = "Day " + str(day) + " "
	$HUD/Label.set_text(dayText + paddedTo2Digits(hour) + ":" + paddedTo2Digits(minute))
	if (day == 0 && hour == 6 && minute == 20):
		$HUD/PlotLabel.set_text("From: S.Bossman; Today's Agenda")
	if (day == 0 && hour == 6 && minute == 29):
		appendToPlot("From: L.Client; Help with setup")
	if (day == 0 && hour == 9 && minute == 10):
		appendToPlot("From: S.Bossman; Where are you?")
	if (day == 0 && hour == 9 && minute == 45):
		appendToPlot("From: C.Tractor; Can't start work without the demo")
	if (day == 0 && hour == 11 && minute == 11):
		appendToPlot("From: Y.Partner; Booked the place for tonight <3")

func appendToPlot(text):
	$HUD/PlotLabel.set_text($HUD/PlotLabel.text + text)

func paddedTo2Digits(time):
	var padded
	if (time < 10):
		padded = "0" + str(time)
	else:
		padded = str(time)
	return padded
