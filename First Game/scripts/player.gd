extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -500.0
var invincible = false
var invincibility_timer = null
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()


func add_invincibility(duration):
	invincible = true
	invincibility_timer = $Timer
	if invincibility_timer:
		invincibility_timer.wait_time = duration
		invincibility_timer.start()
		invincibility_timer.connect("timeout", self, "_on_invincibility_timer_timeout")
	else:
		print("Timer node is not assigned or does not exist")



func _on_invincibility_timer_timeout():
	invincible = false
	invincibility_timer = null 
