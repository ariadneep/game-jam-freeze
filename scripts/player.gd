extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0
const X_ACC = 50;

#^Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000#ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("move_left", "move_right");
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
		velocity.y = JUMP_VELOCITY
		


	move_and_slide()
