extends KinematicBody2D

var velocity : Vector2
var acceleration = 720
var max_speed = 100
var friction = 0.2

onready var animationPlayer = $AnimationPlayer
#onready var animationTree = $AnimationTree
var lastWalkAnimation = "WalkRight"

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		walk_animation(input_vector)
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
	else:
		idle_animation(input_vector)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)			
	
	velocity = move_and_slide(velocity)			

func walk_animation(input_vector):
#		animationTree.set("parameters/Idle/blend_position", input_vector)
#		animationTree.set("parameters/Walk/blend_position", input_vector)
		if input_vector.x > 0:
			animationPlayer.play("WalkRight")
			lastWalkAnimation = "WalkRight"
		elif input_vector.x < 0: 
			animationPlayer.play("WalkLeft")
			lastWalkAnimation = "WalkLeft"
		elif input_vector.x == 0:
			animationPlayer.play(lastWalkAnimation)

func idle_animation(input_vector):
		if lastWalkAnimation == "WalkRight":
			animationPlayer.play("IdleRight")
		elif lastWalkAnimation == "WalkLeft":
			animationPlayer.play("IdleLeft")	
