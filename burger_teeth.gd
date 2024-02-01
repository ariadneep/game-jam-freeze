extends CharacterBody2D

var speed = 150
var player_chase = false
var idle_walk = false;
var player = null

var player_in_range = false;

@export var is_alive = true
@export var player_is_hidden = false;


func _physics_process(delta):
	if player_is_hidden:
		player_chase = false
		player_in_range = true
		idle_walk = true
	if player_chase:
		idle_walk = false;
		$AnimatedSprite2D.play("walk_left")
		if position > player.position:
			$AnimatedSprite2D.flip_h = 0
		if position < player.position:
			$AnimatedSprite2D.flip_h = 1
		position += (player.position - position)/speed

		if Input.is_action_just_pressed("hide"):
			player_is_hidden = true
		if Input.is_action_just_pressed("jump"):
			player_is_hidden = false
		
		if idle_walk:
			position += (player.position - position)/speed
		

func _on_detection_area_body_entered(body):
	player_in_range = true
	if !player_is_hidden:
		player = body
		player_chase = true
	else:
		player = null
		player_chase = false
	



func _on_death_area_body_entered(body):
	if !player_is_hidden:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
