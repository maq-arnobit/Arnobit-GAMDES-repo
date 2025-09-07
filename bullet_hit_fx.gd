extends AnimatedSprite2D

func _ready():
	play()
	$FXTimer.start(0.20)

func _on_fx_timer_timeout():
	queue_free()
