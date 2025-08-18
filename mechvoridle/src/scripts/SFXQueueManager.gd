extends Node

var sfx_queue: Array[AudioStream] = []
var is_processing: bool = false
var audio_bus := "SFX"

func queue_sound(stream: AudioStream):
	if stream == null:
		return

	sfx_queue.append(stream)

	if not is_processing:
		_process_queue()

func _process_queue():
	is_processing = true

	if sfx_queue.is_empty():
		is_processing = false
		return

	var stream = sfx_queue.pop_front()
	var player := AudioStreamPlayer.new()
	player.bus = audio_bus
	player.stream = stream
	player.volume_db = -5.0
	add_child(player)
	player.play()

	# Do NOT wait for the stream to finish — just delay a bit before next one
	await get_tree().create_timer(0.16).timeout  # Adjust to taste
	_process_queue()

	# Optional cleanup after some time
	await get_tree().create_timer(2.0).timeout
	player.queue_free()
