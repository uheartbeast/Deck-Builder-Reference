class_name AsyncTaskManager
extends Resource

var active_tasks := []

signal tasks_completed

func add_task(task: String) -> void:
	active_tasks.append(task)

func remove_task(task: String) -> void:
	active_tasks.erase(task)
	if active_tasks.empty():
		emit_signal("tasks_completed")
