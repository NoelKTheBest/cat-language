extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var attacking = false

@onready var animator = $AnimatedSprite2D


func _process(delta: float) -> void:
	if velocity.y < 0:
		animator.play("jump")
	
	if Input.is_action_just_pressed("attack"):
		animator.play("swipe")
		attacking = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and !attacking: animator.play("fastrun")
		animator.flip_h = true if velocity.x < 0 else false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and !attacking: animator.play("idle")
	
	if velocity.y == JUMP_VELOCITY: animator.play("jump")
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	attacking = false
