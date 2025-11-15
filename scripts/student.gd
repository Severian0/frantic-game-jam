extends CharacterBody2D

@export var game_manager: GameManager

var timer: Timer = Timer.new()
var task_ready = false


func _ready() -> void:
	$Alert.visible = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	wait_for_task()


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("player.interact"):
			game_manager.open_task()


func open_task() -> void:
	pass


func _on_timer_timeout() -> void:
	$Alert.visible = true
	task_ready = true


func wait_for_task() -> void:
	var interval = random_exponential(game_manager.task_rate)
	timer.start(interval)
	
	
func random_exponential(rate: float) -> float:
	var u = randf()
	return -log(u) / rate
