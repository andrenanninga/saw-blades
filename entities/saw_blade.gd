class_name SawBlade
extends CharacterBody2D

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.from_angle(
	randf_range(3.5, 4.5) * (randi_range(0, 1) * 2 - 1) * PI + PI / 2
)

signal hit_player
signal player_jump_over(blade: SawBlade)



func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)

	if collision:
		var collider = collision.get_collider() as Node2D
		
		if collider.is_in_group("player"):
			emit_signal("hit_player")
		else:
			var normal = collision.get_normal()
			
			if normal.x != 0:
				direction.x *= -1
			elif normal.y != 0:
				direction.y *= -1


func _on_jump_over_trigger_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_jump_over", self)
