extends Area2D

@export var spawn_delay: float = 1.0
@export var player: Player

@onready var timer = $Timer

const Saw_blade = preload("res://entities/saw_blade.tscn")
const Coin = preload("res://entities/coin.tscn")
var saw_blades_jumped_over: Array[SawBlade] = []

func _ready():
	timer.start(spawn_delay)
	player.hit_floor.connect(_on_player_hit_floor)



func _on_timer_timeout():
	var new_blade = Saw_blade.instantiate()
	
	new_blade.set_position(Vector2(randf_range(-80, 80), 20))
	new_blade.player_jump_over.connect(_on_player_jump_over_saw_blade)
	
	add_child(new_blade)
	timer.start(spawn_delay)



func _on_body_entered(body):
	if body.is_in_group("saw_blades"):
		body.queue_free()



func _on_player_hit_floor():
	for index in saw_blades_jumped_over.size():
		var blade = saw_blades_jumped_over[index]
		
		var coins_amount = pow(2, index + 1)
		
		for n in coins_amount:
			var coin = Coin.instantiate()
			coin.set_position(blade.get_position())
			add_child(coin)

		blade.queue_free() 
		
	saw_blades_jumped_over = []



func _on_player_jump_over_saw_blade(blade: SawBlade):
	saw_blades_jumped_over.append(blade)
