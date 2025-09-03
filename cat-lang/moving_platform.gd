extends AnimatableBody2D

var player_can_use_spell = false
var anim_paused = false
@onready var anim = $AnimationPlayer

@export var animation_delay: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if animation_delay == 0:
		anim.play("move")
	elif animation_delay > 0:
		$Timer.start(animation_delay)


func play():
	anim.play("move")
	anim_paused = false


func pause():
	anim.pause()
	anim_paused = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_use_spell = true
		print("goo")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_can_use_spell = false
		print("boo")


func _on_timer_timeout() -> void:
	anim.play("move")
