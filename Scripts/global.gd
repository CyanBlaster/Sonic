extends Node
var rings = 0
var score = 0
var time = 0
var act = 1
var goal = false


func _process(delta: float) -> void:
	time += delta
	if(goal):
		goal = false
		act += 1
		if(act == 1):
			get_tree().change_scene_to_file("res://Scenes/act_1.tscn")
		elif(act == 2):
			get_tree().change_scene_to_file("res://Scenes/act_2.tscn")
