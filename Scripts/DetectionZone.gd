extends Area2D

var player = null

func _on_CharacterZone_body_entered(body):
	player = body


func _on_CharacterZone_body_exited(body):
	player = null
