extends Tile
class_name Belt

var texture = preload("res://assets/belt.png")

var direction := Vector2.UP

var items : Array[Dictionary] = []
var max_items = 4

signal rendering

func add_item(item:Item):
	var canvas_item = RenderingServer.canvas_item_create()
	var block = {
		"item": item,
		"offset": 0.0,
		"canvas_item": canvas_item
	}
	items.append(block)
	await self.rendering
	RenderingServer.canvas_item_set_parent(canvas_item, anim_data.canvas_item)
	RenderingServer.canvas_item_set_draw_index(canvas_item,1)
	RenderingServer.canvas_item_set_z_index(canvas_item,1 +position.y)
	RenderingServer.canvas_item_set_sort_children_by_y(canvas_item,true)
	#render_item(block)

func pop_item() -> Item:
	return items.pop_front().item

func init():
	anim_data.frame_size = Vector2(32,32)
	anim_data.max_frames = 4
	anim_data.anim_speed = 12
	anim_data.sheetRID = texture.get_rid()
	anim_data.direction = direction
	add_item(Item.new(preload("res://icon.svg")))
	add_item(Item.new(preload("res://icon.svg")))
	add_item(Item.new(preload("res://icon.svg")))
	add_item(Item.new(preload("res://icon.svg")))
	

func update(delta: float):
	for i:float in len(items):
		var block = items[i]
		var change = min(block.offset+delta,  1 - i/max_items)
		if change != block.offset:
			block.offset = change

	transfer_item()

func transfer_item():
	var next_pos = position + Vector2i(direction)
	if not GridManager.has_tile(next_pos): return
	var next_tile = GridManager.get_tile(next_pos)
	
func render(delta: float,clock: float) -> void:
	anim_data.update_frame(delta,position, clock)
	for block in items:
		render_item(block)

func render_item(block: Dictionary):
	rendering.emit()
	var item_size := Vector2(16,16)
	
	var offset = item_size/2 - Vector2(0,item_size.y) - Vector2(32,32)*block.offset*Vector2.UP #sim numero magico

	var position_rect = Rect2(-offset.x, -offset.y, item_size.x, item_size.y)
	
	var real_pos = position * GridManager.TILE_SIZE
	
	var transform = Transform2D(0,Vector2.ZERO)
	RenderingServer.canvas_item_clear(block.canvas_item)
	RenderingServer.canvas_item_add_texture_rect(block.canvas_item,position_rect,block.item.texture)
	RenderingServer.canvas_item_set_transform(block.canvas_item, transform)
