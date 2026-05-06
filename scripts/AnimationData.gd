extends RefCounted
class_name AnimationData

var actual_frame: float = 0
var max_frames: int
var anim_speed: float
#var sheet_size: Vector2i
var frame_size: Vector2i
var sheetRID: RID
var canvas_item: RID
var is_playing: bool = true

func _init(canvas):
	canvas_item = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(canvas_item, canvas)

func update_frame(delta: float, grid_pos: Vector2i):
	if not is_playing: return
	actual_frame += (float(anim_speed) * delta)
	print(actual_frame)
	
	var frame: int = floor(actual_frame)
	if frame > max_frames:
		actual_frame = 0
		frame = 0
	var real_pos = grid_pos * frame_size
	
	var position_rect = Rect2(real_pos.x,real_pos.y,frame_size.x,frame_size.y)
	var frame_rect = Rect2(frame,0,frame_size.x,frame_size.y)
	RenderingServer.canvas_item_clear(canvas_item)
	RenderingServer.canvas_item_add_texture_rect_region(canvas_item,position_rect,sheetRID,frame_rect)
	
