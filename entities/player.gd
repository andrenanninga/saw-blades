class_name Player
extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_strength : float = 400.0
@export var double_jump_strength : float = 300.0

signal hit_floor

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var was_on_floor = false
var did_double_jump = false

func _physics_process(delta):
	if is_on_floor():
		if !was_on_floor:
			emit_signal("hit_floor")

		was_on_floor = true
	else:
		was_on_floor = false
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

	var collided = move_and_slide()

	if collided:
		var collision = get_last_slide_collision()
		var collider = collision.get_collider() as Node2D

		if collider.is_in_group("saw_blades"):
			SceneManager.change_scene("res://scenes/playground.tscn")
#			queue_free()



func jump():
	did_double_jump = false
	velocity.y = jump_strength * -1

func double_jump():
	did_double_jump = true
	velocity.y = double_jump_strength * -1
