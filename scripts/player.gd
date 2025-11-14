extends CharacterBody2D


@export var speed = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction := Input.get_axis("player.left", "player.right")
	if horizontal_direction:
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var vertical_direction := Input.get_axis("player.forward", "player.back")
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
