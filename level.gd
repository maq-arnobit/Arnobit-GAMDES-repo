extends Node2D
var numberOfHits = 0
@onready var player = $player
@onready var shield_timer = $ShieldTimer
@onready var invul_timer = $InvulnerabilityTimer
@onready var shield_cd_timer = $ShieldCooldownTimer
@onready var shield_cd_label = $ShieldCooldownLabel
@onready var cd_rect = $UI/CooldownRect

func _ready():
	$UI/HealthLabel.set_text('Health: ' + str(player.player_hp))

func _process(delta: float):
	if shield_cd_timer.is_stopped():
		shield_cd_label.set_text('[Q] Shield')
	else:
		shield_cd_label.set_text('[Q] Shield (On Cooldown: ' + str(shield_cd_timer.get_time_left()).pad_decimals(1) + ')')
		cd_rect.size.y = (shield_cd_timer.get_time_left()/10) * 40
		$UI/CooldownLabel.set("theme_override_colors/font_color",Color(1.0,0.0,0.0,1.0))

func _on_player_hit():
	invul_timer.start(2)
	player.is_invul = true
	player.modulate.a = 0.3
	print(player.modulate.a)
	player.player_hp -= 1
	$UI/HealthLabel.set_text('Health: ' + str(player.player_hp))

func _input(event):
	if event.is_action_pressed('skill_1'):
		if player.shield_ready:
			shield_timer.start(3)
			shield_cd_timer.start(10)
			$UI/CooldownRect.show()
			player.is_shielded = true
			player.is_invul = true
			player.shield_ready = false
			
		else:
			print('Shield on cooldown')

func _on_shield_timer_timeout():
	player.is_shielded = false
	player.is_invul = false
	if player.has_overlapping_areas():
		var areas = player.get_overlapping_areas()
		for area in areas:
			if area.is_in_group("enemies"):
				player.hit.emit()

func _on_shield_cooldown_timer_timeout():
	player.shield_ready = true
	$UI/CooldownRect.hide()
	$UI/CooldownLabel.set("theme_override_colors/font_color",Color(1.0,1.0,1.0,1.0))


func _on_invulnerability_timer_timeout() -> void:
	player.modulate.a = 1
	player.is_invul = false
