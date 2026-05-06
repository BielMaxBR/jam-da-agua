@abstract
extends RefCounted
class_name Tile

var position: Vector2i

var anim_data: AnimationData

func _init(canvas: RID, pos: Vector2i) -> void:
	anim_data = AnimationData.new(canvas)
	position = pos

@abstract
func init() -> void

@abstract
func update(delta: float) -> void
