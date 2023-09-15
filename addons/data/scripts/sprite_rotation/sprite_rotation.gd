extends AnimatedSprite3D

var cam
var cam_pos
var look_point_pos
var look_point_dir
var cam_dir
var angle_to_cam
var angle_to_lookpoint
var enemy_angle

func _ready():
	#Get the player's camera
	cam = get_viewport().get_camera_3d();


func _process(delta):
	#Gets the position of the object the sprite is "looking" at
	look_point_pos = get_parent().get_node("RotationRange/Lookpoint").global_position
	look_point_dir = position - look_point_pos

	#Billboards the sprite so it always looks at the player
	cam_pos = cam.global_transform.origin
	look_at(cam_pos, Vector3(0, 1, 0))
	rotation.x = 0


	# Calculate the angle of the sprite, taking into consideration both the object the sprite is looking at
	# and the position of the camera, and convert the radians to degrees for more human friendly readability
	cam_dir = position - cam_pos
	angle_to_cam = rad_to_deg(atan2(cam_dir.x, cam_dir.z))
	angle_to_lookpoint = rad_to_deg(atan2(look_point_dir.x, look_point_dir.z))
	enemy_angle = angle_to_cam - angle_to_lookpoint
	
	#Fix negative degrees
	if enemy_angle < 0:
		enemy_angle += 360
		
	#Here I split up the angle in nice equal chunks so we get 8 even segments for an
	# 8-directional sprite, like most classic FPS games!
	# Feel free to multiply/divide the statements if
	# you want something like only 4-directions or even 16 or more, the limit is your
	# imagination/hardware!
	
	if enemy_angle >= 292.5 && enemy_angle < 337.5:
		play("front_left")

	elif enemy_angle >= 22.5 && enemy_angle < 67.5:
		play("front_right")

	elif enemy_angle >= 67.5 && enemy_angle < 112.5:
		play("right")

	elif enemy_angle >= 112.5 && enemy_angle < 157.5:
		play("back_right")

	elif enemy_angle >= 157.5 && enemy_angle < 202.5:
		play("back")

	elif enemy_angle >= 202.5 && enemy_angle < 247.5:
		play("back_left")

	elif enemy_angle >= 247.5 && enemy_angle < 292.5:
		play("left")
	
	elif enemy_angle >= 337.5 || enemy_angle > 22.5:
		play("front")

