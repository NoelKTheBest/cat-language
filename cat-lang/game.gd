extends Node2D

@onready var path1 = $Node2D
@onready var switch_platform = $SwitchingPlatform
@onready var switch_platform2 = $SwitchingPlatform2
@onready var special_moving_platform = $special_moving_platform_main_node3/MovingPlatform

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
		
		if switch_platform.player_is_close:
			switch_platform.platform_toggle = !switch_platform.platform_toggle
		
		if switch_platform2.player_is_close:
			switch_platform2.platform_toggle = !switch_platform2.platform_toggle
		
		if special_moving_platform.player_can_use_spell:
			if special_moving_platform.anim_paused:
				special_moving_platform.play()
			elif !special_moving_platform.anim_paused:
				special_moving_platform.pause()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = false
