extends Node2D

func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_DamageReceiver_area_entered(area):
	$Sprite.visible = false
	$DamageReceiver.queue_free()
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("destroy")
