extends Node2D

@onready var path1 = $Node2D
@onready var switch_platform = $SwitchingPlatform
@onready var switch_platform2 = $SwitchingPlatform2
@onready var special_moving_platform = $special_moving_platform_main_node3/MovingPlatform
@onready var label = $CharacterBody2D/Label

var player_can_interact

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		$CharacterBody2D/AudioStreamPlayer2D2.play()
		
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
				$Timer.start(10)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_interact = false


func _on_goal_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Has ganado. Felicidades"
		$CharacterBody2D/AudioStreamPlayer2D2.play()
		$EndGame.start(5)


func _on_checkpoint_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Los gatos pueden saltar muy altos. Son ágiles y expertos en la cacería"


func _on_checkpoint_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Este gato puede usar magia que aprendió de su maestra, la bruja usando las velas"


func _on_checkpoint_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Llegamos a la planta de arriba. El gato sabe usar más que un tipo de magia"


func _on_checkpoint_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Ten cuidado, gatito. Esto será un poco complicado para alguien como tú"


func _on_checkpoint_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.text = "Casi llegamos al fin de esta pequeña aventura..."


func _on_timer_timeout() -> void:
	special_moving_platform.play()


func _on_end_game_timeout() -> void:
	get_tree().quit()
