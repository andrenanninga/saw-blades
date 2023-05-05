extends CharacterBody2D

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.from_angle(
	randf_range(3.5, 4.5) * (randi_range(0, 1) * 2 - 1) * PI + PI / 2
)


func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)

	print(direction)

	if collision:
		var normal = collision.get_normal()
		
		if normal.x != 0:
			direction.x *= -1
		elif normal.y != 0:
			direction.y *= -1
