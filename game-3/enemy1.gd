extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var width = 0
var direction = -1
var health = 5
var bullet = preload("res://bullet.tscn")

const EXPLOSION = preload("res://explosion.tscn")

# Used only for enemies created by EnemySpawner.
var edge_hits: int = 0
var exiting: bool = false

# A spawned enemy crosses the screen, bounces once,
# crosses back, then exits.
@export var max_edge_hits_before_exit: int = 2


func _ready() -> void:
	$Timer.start(0.5)
	width = get_viewport_rect().size.x


func get_animated_sprite_2d_size() -> Vector2:
	return animated_sprite_2d.sprite_frames.get_frame_texture(
		animated_sprite_2d.animation,
		animated_sprite_2d.frame
	).get_size()


func _physics_process(_delta: float) -> void:
	var half_width = get_animated_sprite_2d_size().x / 3
	var is_spawned_enemy = is_in_group("spawned_enemies")

	if exiting:
		velocity.x = direction * 85
		move_and_slide()

		if (
			position.x < -half_width
			or position.x > width + half_width
		):
			queue_free()

		return

	# Reached right edge while travelling right.
	if position.x > width - half_width and direction == 1:

		if is_spawned_enemy:
			edge_hits += 1

			if edge_hits >= max_edge_hits_before_exit:
				# Keep moving right until fully offscreen.
				exiting = true
			else:
				direction = -1
				move_down()
		else:
			direction = -1
			move_down()

	# Reached left edge while travelling left.
	elif position.x < half_width and direction == -1:

		if is_spawned_enemy:
			edge_hits += 1

			if edge_hits >= max_edge_hits_before_exit:
				# Do not reverse direction.
				# Keep moving left until fully offscreen.
				exiting = true
			else:
				direction = 1
				move_down()
		else:
			direction = 1
			move_down()

	velocity.x = direction * 85
	move_and_slide()

func move_down() -> void:
	var tween = get_tree().create_tween()

	tween.tween_property(
		self,
		"position:y",
		position.y + 150,
		5.0
	)

func shoot() -> void:
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $bullet_pos.global_position

func _on_timer_timeout() -> void:
	shoot()
	$Timer.start(0.5)

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		var boom = EXPLOSION.instantiate()
		get_tree().current_scene.add_child(boom)
		boom.global_position = global_position
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		take_damage(2)
