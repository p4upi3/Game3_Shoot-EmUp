
extends CharacterBody2D
var bullet = preload("res://bullet.tscn")

const EXPLOSION = preload("res://explosion.tscn")
var health = 3
var direction = 1 

func _physics_process(delta: float) -> void:
	var is_spawned_enemy = is_in_group("spawned_enemies")
	velocity.y = direction * 40
	move_and_slide()
	
	if position.y > 500:
		queue_free()
	return
	
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		take_damage(2)
