extends Area2D
@export var speed = 300
var move = 1
var timer = 0
var screen_size
var movespeed
var random_pos
var random_angle
var direction

func _ready() -> void:
	direction = Vector2(.5, .75).normalized()
	screen_size = get_viewport_rect().size
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	movespeed = rng.randi_range(-40, 180)
	random_angle = rng.randf_range(-0.1,0.5)
	var randomx = rng.randi_range(0,1000)
	var randomy = rng.randi_range(0,500)
	random_pos = Vector2(randomx,randomy)
	position = random_pos

func _process(delta: float) -> void:
	direction = direction.rotated(random_angle * 3 * delta)
	position += direction * movespeed * delta
	rotation = direction.angle()
	if (position.x < 0):
		position.x = 0
		direction.x *= -1
	elif (position.x > screen_size.x):
		position.x = screen_size.x
		direction.x *= -1
	elif (position.y < 0):
		position.y = 0
		direction.y *= -1
	elif (position.y > screen_size.y):
		position.y = screen_size.y
		direction.y *= -1
