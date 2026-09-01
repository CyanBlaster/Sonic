extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var spindash = false
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
		
	if Input.is_action_just_pressed("Jump") and !Input.is_action_pressed("Crouch") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("Left", "Right")
	#if direction && !Input.is_action_pressed("Crouch"):
	if direction:
		if(is_on_floor()):
			if(Input.is_action_pressed("Crouch")):
				animator.play("Jump")
			else:
				animator.play("Walk")
		velocity.x = direction * SPEED
	else:
		if(is_on_floor()):
			if(Input.is_action_pressed("Crouch")):
				if Input.is_action_pressed("Jump"):
					animator.play("Spindash")	
				else:
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
	if not is_on_floor():
		normal.disabled = true
		ball.disabled = false
		attack_area.disabled = false
	elif direction && Input.is_action_pressed("Crouch"):
		normal.disabled = true
		ball.disabled = false
		attack_area.disabled = false
	elif Input.is_action_pressed("Jump") && Input.is_action_pressed("Crouch"):
		spindash = true
		normal.disabled = true
		ball.disabled = false
		attack_area.disabled = false
	else:
		normal.disabled = false
		ball.disabled = true
		attack_area.disabled = true
	if(spindash && !Input.is_action_pressed("Crouch")):
		if(sprite.flip_h):
			velocity.x = -3000
		else:
			velocity.x = 3000
		normal.disabled = true
		ball.disabled = false
		attack_area.disabled = false
		spindash = false

	move_and_slide()
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Spring"):
		velocity.y = 1.4 * JUMP_VELOCITY
	elif area.name.begins_with("motobug") || area.name.begins_with("monitor"):
		velocity.y = JUMP_VELOCITY
