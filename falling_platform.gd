extends CharacterBody2D

var gravity = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravity:
		velocity += get_gravity() * delta

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name.begins_with("Ring")):
		gravity = true
