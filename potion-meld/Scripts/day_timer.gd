extends Label

var prefix = "Time 'til the Wizard returns - "
# decreases at runtime, set this value to 
# determine how long the whole day is
var day_length = 300 # seconds

@onready var gameover_text = $"../GameoverTextLabel" as RichTextLabel

func _on_ready() -> void:
	proc_text()

func _on_timer_timeout() -> void:
	# note: called every second
	proc_text()
	day_length -= 1
	
	if day_length == 60:
		$"/root/World/SoundManager/TimeWarningMinute".play()
	elif day_length == 30:
		$"/root/World/SoundManager/TimeWarning30Sec".play()
	elif day_length <= -1:
		$"/root/World/SoundManager/EndGameChime".play()
		$"/root/World/SoundManager/MusicPlayer".stop()
		gameover_text.visible = true
		gameover_text.text = "[wave amp=20.0 freq=4.0 connected=1]Gameover! \n You served " + str(GameManager.customers_served) + " customers and scored " + str(GameManager.player_score) + " points! \n Press R to restart the game[/wave]"
		$"Timer".stop()
		GameManager.gameover = true

func proc_text() -> String:
	text = prefix
	text += str(floor(day_length / 60)) 
	text += ":"
	var secs = day_length % 60
	if secs < 10:
		secs = "0" + str(secs)
	text += str(secs)
	return text
