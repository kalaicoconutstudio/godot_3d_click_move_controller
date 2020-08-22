# https://github.com/kalaicoconutstudio/godot_3d_click_move_controller
# Kalaicoconut Studio
# Bilibili/卡来椰子工作室

extends StaticBody

onready var stable_camera = get_parent().get_parent().get_parent().get_parent().get_node("Click3DFP")
onready var position = get_parent().get_parent().get_node("Position")
var rot_speed = 1

func _input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position, " shape:", shape_idx)
		stable_camera.move(position.global_transform.origin)
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg2rad(rot_speed))
		if get_parent().rotation_degrees.y > 180:
			get_parent().rotation_degrees.y -= 360
		elif get_parent().rotation_degrees.y < -180:
			get_parent().rotation_degrees.y += 360
