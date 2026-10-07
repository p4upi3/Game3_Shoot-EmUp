
extends CharacterBody2D
var bullet = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 50)
	move_and_slide()
	
func _ready() -> void:
	$Timer.start(0.5)
		
func shoot():
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $bullet_pos.global_position
	
func _on_timer_timeout():
	shoot()
	$Timer.start(0.5)
