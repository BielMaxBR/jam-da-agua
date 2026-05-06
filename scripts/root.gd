extends Node2D

var texture = load("res://icon.svg")
var rid = texture.get_rid()

#var item = RenderingServer.canvas_item_create()
#var trans = Transform2D(0, Vector2(100,100))

#func _ready() -> void:
	
func _physics_process(delta: float) -> void:
	var pos: Vector2i = get_global_mouse_position()
	pos = pos.snapped(GridManager.TILE_SIZE) / GridManager.TILE_SIZE
	
	$Label.text = "(%s, %s)" % [pos.x,pos.y]
	if Input.is_action_just_pressed("click"):
		var belt = Belt.new(get_canvas(), pos)
		GridManager.add_structure(belt,pos)
		belt.init()
	
