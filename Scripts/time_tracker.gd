extends Label

func _process(_delta: float) -> void:
	text = "TIME: " + str(int(global.time))
