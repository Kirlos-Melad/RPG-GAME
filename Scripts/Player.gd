extends KinematicBody2D

export var ROLL_SPEED = 125

var rollDirection = Vector2.DOWN
var isMoving = true

onready var animationManager = $AnimationTree
onready var animationState = animationManager.get("parameters/playback")
onready var body = $DamageReceiver

func _ready():
	animationManager.active = true

func _physics_process(delta):
	var normInputVector = Vector2.ZERO
	normInputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	normInputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	normInputVector = normInputVector.normalized()
	
	if Input.is_action_just_released("attack") && isMoving:
		isMoving = false
		attackState()
	elif Input.is_action_just_released("roll") && isMoving:
		isMoving = false
		rollState()
	elif isMoving:
		moveState(delta, normInputVector)
	
	move_and_slide(body.velocity)

func directionsHandler(normInputVector):
	rollDirection = normInputVector
	$SwordPivot/DamageDealer.attackDirection = normInputVector
	animationManager.set("parameters/IDLE/blend_position", normInputVector)
	animationManager.set("parameters/MOVE/blend_position", normInputVector)
	animationManager.set("parameters/ATTACK/blend_position", normInputVector)
	animationManager.set("parameters/ROLL/blend_position", normInputVector)

func moveState(delta, normInputVector):
	if normInputVector != Vector2.ZERO:
		directionsHandler(normInputVector)
		animationState.travel("MOVE")
		body.velocity = body.velocity.move_toward(normInputVector * body.MAX_SPEED, body.ACCELERATION * delta)
	else:
		animationState.travel("IDLE")
		body.velocity = body.velocity.move_toward(normInputVector, body.motionResistance * delta)


func attackState():
	body.velocity = Vector2.ZERO
	animationState.travel("ATTACK")

func rollState():
	body.velocity = rollDirection * ROLL_SPEED
	animationState.travel("ROLL")

#Associated with attack animation in the AnimationPlayer
func onAttackFinished():
	isMoving = true

#Associated with roll animation in the AnimationPlayer
func onRollFinished():
	body.velocity *= 0.8
	isMoving = true

func _on_DamageReceiver_area_entered(area):
	body.currentHealth -= (area.damage - body.defense)
	body.activateInvincibility(1)


func _on_DamageReceiver_noHealth():
	queue_free()
