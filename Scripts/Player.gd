extends "res://Scripts/Character.gd"

const ACCELERATION = 300
const MAX_SPEED = 100
const ROLL_DISTANCE = 300

var velocity = Vector2.ZERO
var rollSide = Vector2.DOWN

onready var animationManager = $AnimationTree
onready var animationState = animationManager.get("parameters/playback")

func _ready():
	animationManager.active = true
	
	MAX_HEALTH = 100
	currentHealth = 100
	defense = 80
	pushBackResistance = 300
	
	$SowrdPivot/DamageDealer.damage = 100
	$SowrdPivot/DamageDealer.pushBack = 100

func _physics_process(delta):
	var normInputVector = Vector2.ZERO
	normInputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	normInputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	normInputVector = normInputVector.normalized()
	
	if normInputVector != Vector2.ZERO:
		rollSide = normInputVector
		$SowrdPivot/DamageDealer.attackDirection = normInputVector
		animationManager.set("parameters/IDLE/blend_position", normInputVector)
		animationManager.set("parameters/MOVE/blend_position", normInputVector)
		animationManager.set("parameters/ATTACK/blend_position", normInputVector)
		animationManager.set("parameters/ROLL/blend_position", normInputVector)
	
	if animationState.get_current_node() == "IDLE" || animationState.get_current_node() == "MOVE":
		moveState(delta, normInputVector)
	
	if Input.is_action_just_released("attack"):
		attackState()
	elif Input.is_action_just_released("roll"):
		rollState()


func moveState(delta, normInputVector = Vector2.ZERO):
	if normInputVector != Vector2.ZERO:
		animationState.travel("MOVE")
		velocity = velocity.move_toward(normInputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("IDLE")
		velocity = velocity.move_toward(normInputVector, ACCELERATION * 2 * delta)
	
	move_and_slide(velocity)

func attackState():
	animationState.travel("ATTACK")

func rollState():
	animationState.travel("ROLL")
	move_and_slide(ROLL_DISTANCE * rollSide)
