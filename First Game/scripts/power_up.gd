extends Area2D

const INVINCIBILITY_DURATION = 5  # Duration of invincibility in seconds

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_point()
	apply_power_up(body)
	queue_free()
	animation_player.play("pickup")

func apply_power_up(player):
	player.add_invincibility(INVINCIBILITY_DURATION)


func _on_Player_body_entered(body):
	if body.name == "Player":
		body.add_invincibility(INVINCIBILITY_DURATION)
		queue_free()  # Destroy the power-up after collection

