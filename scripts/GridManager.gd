extends Node

var grid: Dictionary[Vector2i,Tile] = {}

var global_list: Array[Tile] = []

var TILE_SIZE = Vector2i(32,32)

func has_structure(pos:Vector2i):
	return grid.has(pos)

func add_structure(struct: Tile,pos:Vector2i):
	if grid.get(pos) != null: return
	grid.set(pos,struct)
	global_list.append(struct)

func delete_strucutre(pos: Vector2):
	var tile = grid.get(pos)
	global_list.erase(tile)
	grid.erase(pos)

var clock = 0
func _process(delta: float) -> void:
	clock += delta
	for tile: Tile in global_list:
		tile.update(delta)
	for tile: Tile in grid.values():
		tile.anim_data.update_frame(delta,tile.position, clock)
