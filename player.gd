extends Area2D
signal hit
@export var speed = 400
@onready var enginefx = $Engine_effects
@onready var shield = $Shield
@onready var ship_sprite = $ShipSprite
@onready var shield_timer_visual = $ShieldTimerVisual
var is_invul = false
var collision_bounds
var is_shielded = false
var shield_ready = true
var player_hp = 3

func _ready() -> void:
	collision_bounds = Vector2(800,520)
	enginefx.play('idle')
	shield.play()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		enginefx.play('powering')
	else:
		enginefx.play('idle')

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, collision_bounds)

	if is_shielded:
		shield.show()
	else:
		shield.hide()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		if !is_invul:
			hit.emit()
		else:
			print('Getting hit but invulnerable')
