extends Node2D

@onready var animator = $AnimationPlayer
var path_open = false

func _ready() -> void:
	$MovingBlock1.position.y = -50


func open_path():
	animator.play("open")
	path_open = true


func close_path():
	animator.play("close")
	path_open = false
