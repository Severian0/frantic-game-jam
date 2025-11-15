extends Node2D
class_name GameManager


@export var gui: GUI
@export var player: Player
# Poisson distribution
# the number of tasks per second on average
@export var task_rate: float = 1.0 / 10.0
@export var quota: int = 40
@export var interaction_distance: float = 1.5 # in metres


var strikes = 0
var students_helped = 0


func open_task(task) -> void:
	var container = gui.get_child(0)
	if container.get_child_count() != 0:
		container.remove_child(container.get_child(0))
	container.add_child(task)


func is_task_open() -> bool:
	return gui.get_child(0).get_child_count() != 0
