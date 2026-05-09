extends Tile
class_name Belt

var texture = preload("res://assets/belt.png")

var direction := Vector2.UP

var items : Array[Dictionary] = []
var max_items = 4

func add_item(item:Item):
	var canvas_item = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(canvas_item, anim_data.canvas)
	RenderingServer.canvas_item_set_draw_index(canvas_item,1)
	var block = {
		"item": item,
		"offset": 0.0,
		"canvas_item": canvas_item
	}
	items.append(block)
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
	#add_item(Item.new(preload("res://icon.svg")))
	#add_item(Item.new(preload("res://icon.svg")))
	#add_item(Item.new(preload("res://icon.svg")))
	

func update(delta: float):
	for i:float in len(items):
		var block = items[i]
		var change = min(block.offset+delta,  1 - i/max_items)
		if change != block.offset:
			block.offset = change
			render_item(block)

func render_item(block: Dictionary):
	var item_size := Vector2(16,16)
	
	
	var offset = item_size/2 + item_size*direction - Vector2(32,32)*block.offset*direction #sim numero magico

	var position_rect = Rect2(-offset.x, -offset.y, item_size.x, item_size.y)
	
	var real_pos = position * GridManager.TILE_SIZE
	
	var transform = Transform2D(0,real_pos)
	RenderingServer.canvas_item_clear(block.canvas_item)
	RenderingServer.canvas_item_add_texture_rect(block.canvas_item,position_rect,block.item.texture)
	RenderingServer.canvas_item_set_transform(block.canvas_item, transform)
