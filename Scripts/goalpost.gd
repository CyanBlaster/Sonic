extends StaticBody2D

@export var animator : AnimationPlayer
var clear = false
var timer = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Ring") and !clear:
		animator.play("Clear")
		clear = true
		timer = 2
func _process(delta: float) -> void:
	if(timer > 0):
		timer -= delta
		if(timer <= 0):
			global.goal = true
