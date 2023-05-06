extends Node2D

@export var timer: Timer

@onready var label: Label = $Label



func _process(delta: float) -> void:
	label.text = str(ceil(timer.time_left)) + "s"
