extends "res://Scripts/Character.gd"

var knockBack = Vector2.ZERO

func _ready():
	MAX_HEALTH = 100
	currentHealth = 100
	defense = 20
	pushBackResistance = 200

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO, pushBackResistance * delta)
	move_and_slide(knockBack)

func _on_DamageReceiver_area_entered(area):
	knockBack = area.pushBack * area.attackDirection
	currentHealth -= area.damage - defense
	
	print(currentHealth)
	if currentHealth < 0:
		queue_free()
