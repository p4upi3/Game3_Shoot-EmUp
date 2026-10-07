extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var width = 0
var direction = -1
var bullet = preload("res://bullet.tscn")

func _ready() -> void:
	$Timer.start(0.5)
	width = get_viewport_rect().size.x

func get_animated_sprite_2d_size() -> Vector2:
	return animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, animated_sprite_2d.frame).get_size()

func _physics_process(delta: float) -> void:
	var half_width = get_animated_sprite_2d_size().x / 3

	if position.x > width - half_width and direction == 1:
		direction = -1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y + 150, 5.0)

	elif position.x < half_width and direction == -1:
		direction = 1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y + 150, 5.0)
	
	velocity.x = direction * 85
	move_and_slide()
	
func shoot():
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $bullet_pos.global_position
	
func _on_timer_timeout():
	shoot()
	$Timer.start(0.5)
