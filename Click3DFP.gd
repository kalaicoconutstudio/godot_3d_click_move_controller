# https://github.com/kalaicoconutstudio/godot_3d_click_move_controller
# Bilibili/卡来椰子工作室
# Kalaicoconut Studio

extends Spatial

onready var rot = $Rot
onready var ui_word = $UIWord
onready var ui_word_label = $UIWord/Label
var rot_target = rotation_degrees
var move_target = global_transform.origin
var state = 'stop'
export var move_inter = 0.01
const ROT_INTER_SLOW = 0.01
const ROT_INTER_QUICK = 0.2
var rot_inter = ROT_INTER_SLOW

func _physics_process(delta):
	if state == 'rotate':
		ui_word_label.text = 'rotate'
		ui_word.show()
		if (rotation_degrees-rot_target).length() < 2:
			state = 'stop'
		elif (rotation_degrees-rot_target).length() < 30:
			while rotation_degrees.y > 180:
				rotation_degrees.y -= 360
			while rotation_degrees.y < -180:
				rotation_degrees.y += 360
			
			while rot_target.y > 180:
				rot_target.y -= 360
			while rot_target.y < -180:
				rot_target.y += 360
			rotation_degrees = rotation_degrees.linear_interpolate(rot_target,rot_inter)
		else:
			rotation_degrees = rotation_degrees.linear_interpolate(rot_target,rot_inter)
	if state == 'move':
		ui_word_label.text = 'move'
		ui_word.show()
		if (global_transform.origin-move_target).length()<1:
			state = 'stop'
		else:
			move_target = Vector3(move_target.x,global_transform.origin.y,move_target.z)
			global_transform.origin = global_transform.origin.linear_interpolate(move_target,move_inter)
	if state == 'stop':
		ui_word.hide()

func move(position_origin):
	if state == 'stop' or state == 'move' or state == 'rotate':
		state = 'move'
		move_target = position_origin

func _on_ButtonLeft_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_SLOW
		rot_target += Vector3(0,90,0)

func _on_ButtonRight_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_SLOW
		rot_target -= Vector3(0,90,0)

func _on_ButtonTurnAroundRight_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_SLOW
		rot_target -= Vector3(0,180,0)

func _on_ButtonTurnAroundLeft_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_SLOW
		rot_target += Vector3(0,180,0)

func _on_ButtonLeftQuick_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_QUICK
		rot_target += Vector3(0,90,0)

func _on_ButtonRightQuick_pressed():
	if state == 'stop' or state == 'rotate' or state == 'move':
		state = 'rotate'
		rot_inter = ROT_INTER_QUICK
		rot_target -= Vector3(0,90,0)
