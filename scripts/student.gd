extends CharacterBody2D

@export var game_manager: GameManager
@export var move_direction: int = 1

var tasks = [preload("res://scenes/tasks/code_task.tscn")]
var timer: Timer
var task = null
var task_ready = false


func _ready() -> void:
	$Alert.visible = false
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	if move_direction == 1:
		$AnimatedSprite2D.play("idle")
	elif move_direction == -1:
		$AnimatedSprite2D.play("idle_back")
	
	wait_for_task()


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("player.interact") and task_ready and global_position.distance_to(game_manager.player.global_position) <= Globals.ppm * game_manager.interaction_distance:
			game_manager.open_task(task)


func _on_timer_timeout() -> void:
	task = tasks.pick_random().instantiate()
	task.on_complete_task.connect(_on_complete_task)
	$Alert.visible = true
	task_ready = true


func _on_complete_task(strikes: int) -> void:
	wait_for_task()
	task = null
	$Alert.visible = false
	task_ready = false


func wait_for_task() -> void:
	var interval = random_exponential(game_manager.task_rate)
	timer.start(interval)
	
	
func random_exponential(rate: float) -> float:
	var u = randf()
	return -log(u) / rate
