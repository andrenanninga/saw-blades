extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_strength : float = 400.0
@export var double_jump_strength : float = 300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var did_double_jump = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif !did_double_jump:
			double_jump()
	
	move_and_slide()



func jump():
	did_double_jump = false
	velocity.y = jump_strength * -1
	
func double_jump():
	did_double_jump = true
	velocity.y = double_jump_strength * -1
