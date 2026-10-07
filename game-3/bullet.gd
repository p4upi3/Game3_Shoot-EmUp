extends Area2D

@export var speed: float = 1500.0
@export var direction: Vector2 = Vector2.DOWN

@onready var ray: RayCast2D = $RayCast2D

const EXPLOSION = preload("res://explosion.tscn")

func _physics_process(delta: float) -> void:
	var motion = direction * speed * delta
	
	ray.target_position = motion
	ray.force_raycast_update()

	if ray.is_colliding():
		global_position = ray.get_collision_point()
		_hit(ray.get_collider())
	else:
		global_position += motion

func _hit(body: Node) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)

		var boom = EXPLOSION.instantiate()
		boom.global_position = global_position
		get_tree().current_scene.add_child(boom)

		queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
