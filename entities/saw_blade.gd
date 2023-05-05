class_name SawBlade
extends CharacterBody2D

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.from_angle(
	PI / 4 + randf_range(-0.2, 0.2) + (PI / 2 * randi_range(0, 1))
)

@onready var sprite = $Sprite2D

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
		sprite.frame = 13
		emit_signal("player_jump_over", self)
