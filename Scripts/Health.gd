extends Control

export var MAX_HEARTS = 1

onready var currentHearts = MAX_HEARTS
onready var fullHeart = $FullHeart
onready var emptyHeart = $EmptyHeart

func _ready():
	MAX_HEARTS = max(MAX_HEARTS, 1)
	setFullHeartPercentile(100)

signal noHearts

func connectPlayer(body):
	body.connect("noHealth", self, "decrementCurrentHearts")
	body.connect("healthChanged", self, "setFullHeartPercentile")

func decrementCurrentHearts():
	currentHearts -= 1
	if currentHearts == 0:
		emit_signal("noHearts")

func setFullHeartPercentile(value):
	#fullHeart.set_deferred("rect_size.x", ((currentHearts - 1) * 15) + ((value / 100) * 15))
	fullHeart.rect_size.x = ((currentHearts) * 15)
