extends Label

var prefix = "Time 'til the Wizard returns - "
# decreases at runtime, set this value to 
# determine how long the whole day is
var day_length = 300 # seconds
# rough times for a customer to show up
# measured in elapsed time; 5 = 5 secs in
var customer_times = [5, 120, 240]

func _on_ready() -> void:
	proc_text()
	# add some randomness to customer appearance times
	for i in range(len(customer_times)):
		customer_times[i] += (randi() % 10) - 5
		customer_times[i] = day_length - customer_times[i]
	print(customer_times)

func _on_timer_timeout() -> void:
	# note: called every second
	proc_text()
	day_length -= 1
	if day_length in customer_times:
		print("customer walks in! at ", day_length)

func proc_text() -> String:
	text = prefix
	text += str(floor(day_length / 60)) 
	text += ":"
	var secs = day_length % 60
	if secs < 10:
		secs = "0" + str(secs)
	text += str(secs)
	return text
