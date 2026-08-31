extends StaticBody2D

@export var animator: AnimationPlayer
func _process(_delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name.begins_with("Ring Collector")):
		animator.play("Spring")
