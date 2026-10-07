extends Node2D

const ENEMY_SCENE1 = preload("res://enemy1.tscn")
const ENEMY_SCENE2 = preload("res://enemy_2.tscn")
const ENEMY_SCENE3 = preload("res://enemy_3.tscn")

@export var spawn_interval: float = 2.0
@export var offscreen_padding: float = 40.0
@export var max_spawned_enemies: int = 4

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_enemy1()


func spawn_enemy1() -> void:
	var existing_enemies = get_tree().get_nodes_in_group("spawned_enemies")

	if existing_enemies.size() >= max_spawned_enemies:
		return

	var enemy = ENEMY_SCENE1.instantiate()

	get_tree().current_scene.add_child(enemy)

	enemy.add_to_group("spawned_enemies")

	var viewport_size = get_viewport_rect().size

	var spawn_y = randf_range(
		30.0,
		viewport_size.y - 80.0
	)

	enemy.global_position = Vector2(
		viewport_size.x + offscreen_padding,
		spawn_y
	)

func spawn_enemy2() -> void:
	var existing_enemies = get_tree().get_nodes_in_group("spawned_enemies")

	if existing_enemies.size() >= max_spawned_enemies:
		return

	var enemy = ENEMY_SCENE2.instantiate()

	get_tree().current_scene.add_child(enemy)

	enemy.add_to_group("spawned_enemies")

	var viewport_size = get_viewport_rect().size

	var spawn_y = randf_range(
		30.0,
		viewport_size.y - 80.0
	)

	enemy.global_position = Vector2(
		viewport_size.x + offscreen_padding,
		spawn_y
	)
	
func spawn_enemy3() -> void:
	var existing_enemies = get_tree().get_nodes_in_group("spawned_enemies")

	if existing_enemies.size() >= max_spawned_enemies:
		return

	var enemy = ENEMY_SCENE3.instantiate()

	get_tree().current_scene.add_child(enemy)

	enemy.add_to_group("spawned_enemies")

	var viewport_size = get_viewport_rect().size

	var spawn_y = randf_range(
		30.0,
		viewport_size.y - 80.0
	)

	enemy.global_position = Vector2(
		viewport_size.x + offscreen_padding,
		spawn_y
	)
