extends Node2D
class_name GameManager


@export var gui: GUI
# Poisson distribution
# the number of tasks per second on average
@export var task_rate = 1.0 / 10.0


var tasks = [preload("res://scenes/tasks/code_task.tscn")]


func open_task() -> void:
	var rand_task = tasks.pick_random()
	var task_ui = rand_task.instantiate()
	gui.add_child(task_ui)
	
	
