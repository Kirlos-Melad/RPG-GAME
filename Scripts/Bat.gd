extends KinematicBody2D

var knockBack = Vector2.ZERO
var isDead = false
onready var body = $DamageReceiver

func _physics_process(delta):
	if !isDead:
		knockBack = knockBack.move_toward(Vector2.ZERO, body.pushBackResistance * delta)
		move_and_slide(knockBack)

func _on_DamageReceiver_area_entered(area):
	knockBack = area.pushBack * area.attackDirection
	body.currentHealth -= area.damage - body.defense


func _on_DamageReceiver_noHealth():
	$DamageReceiver.queue_free()
	isDead = true
	$BatSprite.play("death")


func _on_BatSprite_animation_finished():
	if isDead:
		queue_free()
