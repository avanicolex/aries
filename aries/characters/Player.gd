extends KinematicBody2D


#player state
enum{
	ATTACK,
	MOVE,
	IDLE
}


#player facing direction
enum{
	UP,
	DOWN,
	LEFT,
	RIGHT
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MAX_SPEED = 100

onready var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree

var playerState = IDLE
var facingDirection = DOWN


# Called when the node enters the scene tree for the first time.
func _ready():
	#print('Ready has called')
	#print(velocity)
	pass # Replace with function body.

func _getInput():
	var input_vector = Vector2()

	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		animationPlayer.play("go_up")
	elif Input.is_action_pressed("ui_down"):
		input_vector.y += 1
		animationPlayer.play("go_down")
	elif Input.is_action_pressed("ui_right"):
		input_vector.x += 1
		animationPlayer.play("go_right")
	elif Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
		animationPlayer.play("go_left")
	else:
		animationPlayer.play("idle_down")


	velocity = input_vector.normalized()
	#_GetPlayerDirection()
	
func _GetPlayerDirection():
	if velocity.x != 0 && velocity.y != 0 :
		if velocity.y <= 0 && velocity.x == 0:
			facingDirection = UP
			animationPlayer.play("go_up")
		elif velocity.y == 0 && velocity.x <=0:
			facingDirection = LEFT
			animationPlayer.play("go_left")
		elif velocity.y >= 0 && velocity.x == 0:
			facingDirection = DOWN
			animationPlayer.play("go_down")
		elif velocity.y == 0 && velocity.x >= 0:
			facingDirection = RIGHT
			animationPlayer.play("go_right")
		playerState = MOVE
	else:
		playerState = IDLE
	print(playerState)
	print(facingDirection)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print('process called')
	#print(delta)
	_getInput()
	
	velocity = move_and_collide(velocity)
	

