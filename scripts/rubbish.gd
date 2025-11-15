extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total = $AnimatedSprite2D.sprite_frames.get_frame_count("default")
	$AnimatedSprite2D.frame = randi() % total
