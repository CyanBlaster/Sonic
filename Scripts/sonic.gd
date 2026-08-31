extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var sprite : Sprite2D
@export var animator : AnimationPlayer
@export var normal : CollisionShape2D
@export var ball : CollisionShape2D
@export var attack_area : CollisionShape2D
func _ready():
	normal.disabled = false
	ball.disabled = true
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		animator.play("Jump")
		velocity += get_gravity() * delta
		normal.disabled = true
		ball.disabled = false
		attack_area.disabled = false
	else:
		normal.disabled = false
		ball.disabled = true
		attack_area.disabled = true
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	#if direction && !Input.is_action_pressed("ui_down"):
	if direction:
		if(is_on_floor()):
			if(Input.is_action_pressed("ui_down")):
				animator.play("Jump")
			else:
				animator.play("Walk")
		velocity.x = direction * SPEED
	else:
		if(is_on_floor()):
			if(Input.is_action_pressed("ui_down")):
				animator.play("Crouch")
			elif(Input.is_action_pressed("ui_up")):
				animator.play("Look Up")
			else:
				animator.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if(direction > 0):
		sprite.flip_h = false
	elif(direction < 0):
		sprite.flip_h = true
	move_and_slide()
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.name.begins_with("ring"):
		global.rings += 1
	else:
		velocity.y = JUMP_VELOCITY
