extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = -100
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Ball"):
		queue_free()

func _on_area_2d_area_entered(body: Area2D) -> void:
	print(body.name)
	if body.name.begins_with("Attack Area"):
		queue_free()
