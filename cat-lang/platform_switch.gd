extends Node2D

@onready var circle_platform = $StaticBody2D
@onready var circle_collider = $StaticBody2D/CollisionShape2D
@onready var square_platform = $StaticBody2D2
@onready var square_collider = $StaticBody2D2/CollisionShape2D2

@export var start_as_circle = false
var platform_toggle = false
var player_is_close = false

func _ready() -> void:
	if start_as_circle: platform_toggle = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if platform_toggle:
		circle_platform.visible = true
		circle_collider.disabled = false
		square_platform.visible = false
		square_collider.disabled = true
	elif !platform_toggle:
		circle_platform.visible = false
		circle_collider.disabled = true
		square_platform.visible = true
		square_collider.disabled = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_close= true
		print("inside")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_close = false
		print("out")
