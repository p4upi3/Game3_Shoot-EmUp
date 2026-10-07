
extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var direction = 1 
var health = 3
var bullet = preload("res://bullet.tscn")

const EXPLOSION = preload("res://explosion.tscn")

func _physics_process(delta: float) -> void:
	velocity.x = direction * 50
	move_and_slide()

	var half_width = animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, animated_sprite_2d.frame).get_size().x / 2

	if position.x < -half_width:
		queue_free()
		
func _ready() -> void:
	$Timer.start(0.5)
		
func shoot():
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $bullet_pos.global_position
	
func _on_timer_timeout():
	shoot()
	$Timer.start(0.5)

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		var boom = EXPLOSION.instantiate()
		get_tree().current_scene.add_child(boom)
		boom.global_position = global_position
		queue_free()
