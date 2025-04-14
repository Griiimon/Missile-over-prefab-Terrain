extends CharacterBody2D

@export var speed: float= 200.0



func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x+= speed * delta
