extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu/VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	await FadeLayer.change_scene_radial("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	$MainMenu.visible = false
	$Options.visible = true
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_easter_egg_pressed() -> void:
	$AlexDixonMenu.visible = false
	$JamesArchBizzle.visible = true
	


func _on_back_pressed() -> void:
	
	$Options.visible = false
	$MainMenu.visible = true
