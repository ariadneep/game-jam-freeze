extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0
const X_ACC = 50;
var is_alive = true
var player_is_hidden = false

signal HidingStatus(player_is_hidden)
signal LifeStatus(is_alive)

#^Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000#ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	var x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#modify animation:
	if is_on_floor():
		if x_direction == 0:
			$AnimatedSprite2D.play("stand_idle")
		elif x_direction < 0:
			$AnimatedSprite2D.play("walk_left")
		elif x_direction > 0:
			$AnimatedSprite2D.play("walk_right")
		
	# Add the gravity.
	if !is_on_floor():
		if velocity.y < 1000:
			velocity.y += gravity * delta
		else:
			velocity.y = 1000

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_is_hidden = false
		velocity.y = JUMP_VELOCITY
		HidingStatus.emit(player_is_hidden)
		
	if Input.is_action_just_pressed("hide"):
		player_is_hidden = true
		HidingStatus.emit(player_is_hidden)
		


	move_and_slide()
