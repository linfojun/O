class_name oo_c
extends RigidBody2D

@export var Type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	match Type:
		0:
			$AnimatedSprite2D.play("M")
		1:
			$AnimatedSprite2D.play("H")
		2:
			$AnimatedSprite2D.play("T")
		3:
			$AnimatedSprite2D.play("J")
		4:
			$AnimatedSprite2D.play("S")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
