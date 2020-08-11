extends Node2D

func _ready():
	randomize()
	$CanvasLayer/Health.connectPlayer($YSort/Player.body)
	$CanvasLayer/Health.connect("noHearts", $YSort/Player, "on_noHearts")
