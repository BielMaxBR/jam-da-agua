extends Tile
class_name Belt

var texture = preload("res://assets/belt.png")

func init():
	anim_data.frame_size = Vector2(32,32)
	anim_data.max_frames = 4
	anim_data.anim_speed = 4
	anim_data.sheetRID = texture.get_rid()

func update(delta: float):
	anim_data.update_frame(delta,position)
