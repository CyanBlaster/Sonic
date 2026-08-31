extends StaticBody2D



@export var animator : AnimationPlayer


func _process(_delta: float) -> void:
	animator.play("Ring")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name.begins_with("Attack Area")):
		queue_free()
