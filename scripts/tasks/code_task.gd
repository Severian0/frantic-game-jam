extends Node

@export var editor: TextEdit
@export var p_impossible = 0.01
@export var impossible: String

var questions: Array[String]
var answers: Array[String]
var q_index = -1 # -1 means impossible

func _ready() -> void:
	var qlen = _load_folder_texts("res://resources/tasks/code_task/questions", questions)
	var alen = _load_folder_texts("res://resources/tasks/code_task/answers", answers)
	if qlen != alen:
		push_error("Length of questions and answers array does not match")
	print("Loaded %d question(s) and %d answer(s)." % [questions.size(), answers.size()])
	
	if randf() <= p_impossible:
		q_index = -1
		var file = FileAccess.open("res://resources/tasks/code_task/impossible.txt", FileAccess.READ)
		var code = file.get_as_text()
		file.close()
		editor.text = code
		return
	q_index = randi_range(0, qlen - 1)
	editor.text = questions[q_index]


func _load_folder_texts(folder_path: String, out_array: Array) -> int:
	var dir = DirAccess.open(folder_path)
	if dir == null:
		push_error("Unable to open folder: %s" % folder_path)
		return -1

	# Collect file names first so we can sort them (optional but keeps order predictable)
	var files: Array = []
	dir.list_dir_begin()         # start listing
	var dirname: String = dir.get_next()
	while dirname != "":
		# skip directories and hidden files
		if not dir.current_is_dir() and dirname.to_lower().ends_with(".txt"):
			files.append(dirname)
		dirname = dir.get_next()
	dir.list_dir_end()

	files.sort() # alphabetical order; remove if you want the filesystem order

	for filename in files:
		var path = "%s/%s" % [folder_path.rstrip("/"), filename]
		var file = FileAccess.open(path, FileAccess.READ)
		if file:
			var text := file.get_as_text()
			file.close()
			out_array.append(text)
		else:
			push_warning("Failed to open file: %s" % path)
	return len(files)


# 3 outcomes
# correct
# incorrect - 1 strike
# deleted code - 2 strikes
func _on_button_pressed() -> void:
	if q_index == -1:
		print("WRONG!")
	elif editor.text.strip_edges() == answers[q_index].strip_edges():
		print("Correct")
	else:
		print("Incorrect")
