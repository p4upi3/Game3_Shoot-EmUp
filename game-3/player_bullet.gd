extends Area2D

@export var speed: float = 250.0
@export var direction: Vector2 = Vector2.UP


func _physics_process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
