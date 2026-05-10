extends Node

var grid: Dictionary[Vector2i,Tile] = {}

var render_list: Array[Vector2] = []

var global_canvas_item := RenderingServer.canvas_item_create()


var TILE_SIZE = Vector2i(32,32)

func _init() -> void:
	RenderingServer.canvas_item_set_sort_children_by_y(global_canvas_item,true)
func _ready() -> void:
	RenderingServer.canvas_item_set_parent(global_canvas_item,Globals.root.get_canvas())

func has_tile(pos:Vector2i):
	return grid.has(pos)

func add_tile(struct: Tile,pos:Vector2i):
	if grid.get(pos) != null: return
	grid.set(pos,struct)
	
	for i in len(render_list):
		var actual_pos = render_list[i]
		if actual_pos.y >= pos.y:
			render_list.insert(i,pos)
			return
	render_list.append(pos)

func get_tile(pos: Vector2i):
	if has_tile(pos):
		return grid.get(pos)
	else:
		return null

func delete_tile(pos: Vector2i):
	grid[pos].delete()
	render_list.erase(pos)
	grid.erase(pos)

var clock = 0
func _process(delta: float) -> void:
	clock += delta
	for tile: Tile in grid.values():
		tile.update(delta)
	for pos: Vector2i in render_list:
		var tile = grid.get(pos)
		#print(pos.y)
		tile.render(delta,clock)
	#print('----------------')
