extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name.begins_with("Attack Area")):
		global.rings += 10
		queue_free()
