extends KinematicBody2D

const GRAVITY = 500.0

const FLOOR_ANGLE_TOLERANCE = 60
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 200
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0  # one pixel/ second
const SLIDE_MIN_STOP_TRAVEL = 1.0  # one pixel

var in_air_time = 0
var jumping = false
var velocity = Vector2()

var prev_jump_pressed = false

func _process(delta):
	if velocity.x != 0:
		$AnimatedSprite.play("walking")
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.play("idle")

func _physics_process(delta):
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_up")
	
	var stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false

	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	velocity += force * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		in_air_time = 0
	
	if jumping and velocity.y > 0:  # velocity.y > 0 means falling
		jumping = false
	
	if in_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		velocity.y = -JUMP_SPEED
		jumping = true
	
	in_air_time += delta
	prev_jump_pressed = jump
	
	
