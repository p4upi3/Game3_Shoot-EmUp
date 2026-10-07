extends Area2D

@export var speed: float = 250.0
@export var direction: Vector2 = Vector2.UP

const EXPLOSION = preload("res://small_explosion.tscn")

func _physics_process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(1)
		var boom = EXPLOSION.instantiate()
		get_tree().current_scene.add_child(boom)
		boom.global_position = global_position
		queue_free()
