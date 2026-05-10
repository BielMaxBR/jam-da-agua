extends RefCounted
class_name AnimationData

var actual_frame: float = 0
var max_frames: int
var anim_speed: float

var frame_size: Vector2i
var direction: Vector2 = Vector2.LEFT

var sheetRID: RID
var canvas_item: RID
var canvas: RID

var is_playing: bool = true
var is_synced = true

func _init(_canvas: RID):
	canvas = _canvas
	canvas_item = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(canvas_item, canvas)
	RenderingServer.canvas_item_set_draw_index(canvas_item,1)
	RenderingServer.canvas_item_set_sort_children_by_y(canvas_item,true)
	

func update_frame(delta: float, grid_pos: Vector2i, clock: float):
	if not is_playing: return
	if is_synced:
		actual_frame = clock * float(anim_speed)
	else:
		actual_frame += (float(anim_speed) * delta)
	
	var frame: int = floori(actual_frame) % max_frames

	var real_pos = grid_pos * GridManager.TILE_SIZE
	#print(frame)
	var offset = frame_size/2
	var position_rect = Rect2(-offset.x,-offset.y,frame_size.x,frame_size.y)
	var frame_rect = Rect2(frame*frame_size.x,0,frame_size.x,frame_size.y)
	
	var angle = direction.angle() + PI/2
	#var angle = tan(clock) - sin(clock)
	var transform = Transform2D(angle,real_pos)
	RenderingServer.canvas_item_clear(canvas_item)
	RenderingServer.canvas_item_add_texture_rect_region(canvas_item,position_rect,sheetRID,frame_rect)
	RenderingServer.canvas_item_set_transform(canvas_item, transform)

func delete():
	RenderingServer.canvas_item_clear(canvas_item)
