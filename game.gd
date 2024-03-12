extends Node2D

@export var oo_scene : PackedScene
var score = 0
var real_score = 0
var cur_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = 0
	$O.hide()
	$StartTimer.start()

func game_over():
	$ooTimer.stop()

func _on_start_timer_timeout():
	$O.start($StartPosition.position)
	$ooTimer.start()
	

func _on_oo_timer_timeout():
	var oo = oo_scene.instantiate()
	oo.Type = randi_range(0, 4)
	var oo_spawn_loc = $ooPath/ooSpawnLoc
	oo_spawn_loc.progress_ratio = randf()
	var direction = oo_spawn_loc.rotation + PI / 2
	oo.position = oo_spawn_loc.position
	direction += randf_range(-PI / 4, PI / 4)
	oo.rotation = direction
	
	var velocity = Vector2(randf_range(200.0, 400.0), 0.0)
	oo.linear_velocity = velocity.rotated(direction)
	
	add_child(oo)



func _on_o_hit(type):
	push_warning(type)
	if type == cur_idx:
		# 吃对了，暂时分数+1，等分数到5时才真正得分
		cur_idx += 1
		score += 1
		$Label.text = str(real_score + score)
		if score == 5:
			# 重置idx，和score, 新增real_score
			cur_idx = 0
			score = 0
			real_score += 5
			if real_score == 100:
				await get_tree().create_timer(0.1).timeout
				get_tree().change_scene_to_file("res://end.tscn")
				# 游戏结束
	else: 
		# 吃错了，分数回退
		cur_idx = 0
		score = 0
		$Label.text = str(real_score + score)
	# 必须按照木火土金水的顺序吃，才会加分
	
