extends CanvasLayer

@onready var rect := $ColorRect

func fade_out(duration := 0.6):
	var tween = create_tween()
	tween.tween_property(rect.material, "shader_parameter/radius", 0.0, duration)
	return tween

func fade_in(duration := 0.6):
	var tween = create_tween()
	tween.tween_property(rect.material, "shader_parameter/radius", 1.5, duration)
	return tween

func change_scene_radial(path: String):
	await fade_out()
	get_tree().change_scene_to_file(path)
	await fade_in()
