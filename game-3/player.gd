extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 100.0
const MARGIN = 10.0
const BOTTOM_BAR = 25.0
var health = 20
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	move_and_slide()

	if direction.x < 0:
		sprite.play("left")
	elif direction.x > 0:
		sprite.play("right")
	else:
		sprite.play("default")

	position.x = clamp(position.x, MARGIN, screen_size.x - MARGIN)
	position.y = clamp(position.y, MARGIN, screen_size.y - BOTTOM_BAR - MARGIN)

func take_damage(amount: int) -> void:
	health -= amount
	get_tree().call_group("hud", "set_health", health)
	if health <= 0:
		get_tree().call_group("hud", "show_game_over")
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		take_damage(2)
