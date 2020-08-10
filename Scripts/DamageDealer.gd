extends Area2D

export var damage = 0
export var pushBack = 0
var attackDirection = Vector2.ZERO
onready var sprite = $AnimatedSprite


func _on_DamageDealer_area_entered(area):
	sprite.position = area.position
	sprite.visible = true
	sprite.play()


func _on_AnimatedSprite_animation_finished():
	sprite.visible = false
