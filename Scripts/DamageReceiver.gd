extends Area2D

export var MAX_HEALTH = 0
export var defense = 0
export var pushBackResistance = 0
onready var currentHealth = MAX_HEALTH setget setCurrentHealth

signal noHealth

func setCurrentHealth(value):
	currentHealth = value
	if currentHealth <= 0:
		emit_signal("noHealth")
