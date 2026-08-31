extends CharacterBody2D

@export var sprite : Sprite2D

var velo = -100
var timer = 0
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = velo
	if is_on_wall() && timer <= 0:
		velo *= -1
		timer = 0.1
		if(sprite.flip_h):
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		timer -= delta
	move_and_slide()
func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass
func _on_area_2d_area_entered(body: Area2D) -> void:
	if body.name.begins_with("Attack Area"):
		global.score += 100
		queue_free()
