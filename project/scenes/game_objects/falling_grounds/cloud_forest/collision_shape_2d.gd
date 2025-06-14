extends CollisionShape2D

@onready var falling_ground = get_parent()

func _ready():
	await get_parent().ready
	for x in 3:
		print(x)
		var xdup = self.duplicate()
		self.get_parent().add_child.call_deferred(xdup)
		xdup.position += Vector2(32*int(x),0)
	queue_free()
