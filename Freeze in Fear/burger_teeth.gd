extends CharacterBody2D

var speed = 250
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		if position > player.position:
			$AnimatedSprite2D.play("walk_left")
		

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false



func _on_death_area_body_entered(body):
	if player_chase:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
