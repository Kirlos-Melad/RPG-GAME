extends KinematicBody2D

var anti_motion = Vector2.ZERO
var isDead = false
var isWandering = false

export var Wander_ABS_Error = 0

onready var body = $DamageReceiver
onready var detectionZone = $DetectionZone
onready var wanderController = $WanderController

func _ready():
	changeState()

func _physics_process(delta):
	if !isDead:
		anti_motion = anti_motion.move_toward(Vector2.ZERO, body.motionResistance * delta)
		move_and_slide(anti_motion)
		
		if detectionZone.player != null:
			moveTo(delta, detectionZone.player.global_position)
		else:
			if isWandering:
				moveTo(delta, wanderController.newPosition)
				if global_position.distance_to(wanderController.newPosition) <= Wander_ABS_Error:
					changeState()
			else:
				body.velocity = body.velocity.move_toward(Vector2.ZERO, body.motionResistance * delta)
		
		move_and_slide(body.velocity)

func moveTo(delta, position):
	var dir = global_position.direction_to(position)
	body.velocity = body.velocity.move_toward(dir * body.MAX_SPEED, body.ACCELERATION * delta)
	$BatSprite.flip_h = (body.velocity.x < 0)

func changeState():
	self.isWandering = bool(randi() % 2)
	print(self.isWandering, " ", bool(randi() % 2))
	wanderController.startWandering(rand_range(1, 3))

func _on_DamageReceiver_area_entered(area):
	anti_motion = area.pushBack * area.attackDirection
	body.currentHealth -= area.damage - body.defense


func _on_DamageReceiver_noHealth():
	body.get_child(0).disabled = true
	isDead = true
	$BatSprite.play("death")


func _on_BatSprite_animation_finished():
	if isDead:
		queue_free()


func _on_Timer_timeout():
	changeState()
