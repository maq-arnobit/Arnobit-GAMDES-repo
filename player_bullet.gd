extends Area2D
@export var speed = 400

func _ready():
	$sprite.play()
	
func _process(delta: float):
	var velocity = Vector2(0,-1)
	print(velocity.y)
	velocity = velocity.normalized() * speed
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D):
	if area.is_in_group("enemies"):
		queue_free()
