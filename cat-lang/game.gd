extends Node2D

@onready var path1 = $Node2D
@onready var moving_platform = $MovingBody

var player_can_interact

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		if player_can_interact:
			if !path1.path_open: path1.open_path()
			elif path1.path_open: path1.close_path()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = true


func _on_timer_timeout() -> void:
	moving_platform.start_timer(5)
	if moving_platform.is_down: moving_platform.move_up()
	elif !moving_platform.is_down: moving_platform.move_down()
