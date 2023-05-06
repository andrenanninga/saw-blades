extends Node2D

@export var attempt_duration: int = 60
@export var spawn_delay: float = 1.0

@onready var player: Player = $Player
@onready var attempt_timer: Timer = $AttemptTimer
@onready var spawn_timer: Timer = $SawBladeSpawnTimer
@onready var score_label: Label = $ScoreLabel

const Saw_blade = preload("res://entities/saw_blade.tscn")
const Coin = preload("res://entities/coin.tscn")

var score: int = 0

# List of blades jumped over in single jump
# When player lands these blades are destroyed
var saw_blades_jumped_over: Array[SawBlade] = []



func _ready():
	_start()



func _start():
	player.hit_floor.connect(_on_player_hit_floor)

	attempt_timer.start(attempt_duration)
	spawn_timer.start(spawn_delay)



func _on_attempt_timer_timeout() -> void:
	print("finished")
	pass



func _on_spawn_timer_timeout():
	var new_blade = Saw_blade.instantiate()

	new_blade.set_position(Vector2(randf_range(20, 180), -10))
	new_blade.player_jump_over.connect(_on_player_jump_over_saw_blade)

	add_child(new_blade)
	spawn_timer.start(spawn_delay)



func _on_coin_pickup():
	var next_time_left = minf(
		attempt_timer.time_left + 1,
		attempt_duration
	)

	attempt_timer.start(next_time_left)



func _on_player_hit_floor():
	score += saw_blades_jumped_over.size()
	score_label.text = str(score)

	for index in saw_blades_jumped_over.size():
		var blade = saw_blades_jumped_over[index]
		var coins_amount = pow(2, index)

		for n in coins_amount:
			var coin = Coin.instantiate()
			coin.pickup.connect(_on_coin_pickup)
			coin.set_position(blade.get_position())
			add_child(coin)

		blade.queue_free()

	saw_blades_jumped_over = []



func _on_player_jump_over_saw_blade(blade: SawBlade):
	saw_blades_jumped_over.append(blade)
