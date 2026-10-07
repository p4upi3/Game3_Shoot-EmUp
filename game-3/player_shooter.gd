extends Node

const PLAYER_BULLET = preload("res://player_bullet.tscn")

@export var fire_interval: float = 0.18

var fire_cooldown: float = 0.0

@onready var shot_spawn: Marker2D = $"../ShotSpawn"


func _process(delta: float) -> void:
	if fire_cooldown > 0.0:
		fire_cooldown -= delta

	if Input.is_action_pressed("shoot") and fire_cooldown <= 0.0:
		shoot()
		fire_cooldown = fire_interval


func shoot() -> void:
	var projectile = PLAYER_BULLET.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = shot_spawn.global_position
