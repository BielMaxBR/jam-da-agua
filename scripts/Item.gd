extends RefCounted
class_name Item

var texture: RID

func _init(_texture: Texture2D):
	texture = _texture.get_rid()
