extends CharacterBody2D
class_name Player


@export var speed = 300.0
@export var sprite: AnimatedSprite2D
@export var game_manager: GameManager


var move_direction = 1


func _physics_process(delta: float) -> void:
	if game_manager.is_task_open():
		return
	
	var moving = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction := Input.get_axis("player.left", "player.right")
	if horizontal_direction:
		velocity.x = horizontal_direction * speed
		moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var vertical_direction := Input.get_axis("player.forward", "player.back")
	if vertical_direction:
		velocity.y = vertical_direction * speed
		move_direction = vertical_direction
		moving = true
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	velocity = velocity.normalized() * speed

	if move_direction == 1:
		if moving:
			sprite.play("walking")
		else:
			sprite.play("idle")
	elif move_direction == -1:
		if moving:
			sprite.play("walking_back")
		else:
			sprite.play("idle_back")

	move_and_slide()
