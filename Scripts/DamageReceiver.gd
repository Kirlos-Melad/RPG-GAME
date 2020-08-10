extends Area2D

export var MAX_HEALTH = 0
export var defense = 0
export var motionResistance = 0
export var MAX_SPEED = 0
export var ACCELERATION = 0

var velocity = Vector2.ZERO

onready var currentHealth = MAX_HEALTH setget setCurrentHealth

signal noHealth
signal invincibleActive
signal invincibleInactive

func setCurrentHealth(value):
	currentHealth = value
	if currentHealth <= 0:
		emit_signal("noHealth")

func activateInvincibility(duration):
	$Timer.start(duration)
	emit_signal("invincibleActive")

func _on_Timer_timeout():
	emit_signal("invincibleInactive")


func _on_DamageReceiver_invincibleActive():
	$CollisionShape2D.set_deferred("disabled", true)


func _on_DamageReceiver_invincibleInactive():
	$CollisionShape2D.disabled = false
