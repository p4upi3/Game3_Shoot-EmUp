extends CanvasLayer

var score = 0

func _ready() -> void:
	set_health(20)
	add_score(0)

func set_health(value: int) -> void:
	$HealthLabel.text = "Health: " + str(value)

func add_score(amount: int) -> void:
	score += amount
	$Scorelabel.text = "Score: " + str(score)

func show_game_over() -> void:
	$GameOverLabel.visible = true
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if get_tree().paused and event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		get_tree().reload_current_scene()
