extends Node2D

const SPEED = 120
const DETECTION_RADIUS = 100
var player = null
var direction = 1

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	player = get_node("/root/Game/Player")  # Adjust the path to your player node

func _process(delta):
	if player and position.distance_to(player.position) < DETECTION_RADIUS:
		follow_player(delta)

func follow_player(delta):
	var direction = (player.position - position).normalized()
	position += direction * SPEED * delta

	if direction.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

