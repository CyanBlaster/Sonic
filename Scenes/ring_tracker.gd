extends Label

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	text = "RINGS: " + str(global.rings)
