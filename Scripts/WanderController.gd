extends Node2D

export var Wander_Range = Vector2.ZERO

onready var startPosition = global_position
onready var newPosition = global_position
onready var timer = $Timer

func _ready():
	updateNewPosition()

func updateNewPosition():
	var pos = Vector2(rand_range(-Wander_Range.x, Wander_Range.x), rand_range(-Wander_Range.y, Wander_Range.y))
	newPosition = startPosition + pos

func startWandering(offSetTime):
	timer.start(offSetTime)

func getTimeLeft():
	return timer.time_left

func _on_Timer_timeout():
	updateNewPosition()
