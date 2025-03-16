extends Sprite2D

@export var idealPosition: Vector2

signal pieceLocked

#dragging concept from Reddit
var dragging = false
var locked = false

func _ready() -> void:
	print(self.name)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and get_rect().has_point(to_local(event.position)):
			if (!locked && !get_parent().onePieceBeingDragged):
				dragging = true
				get_parent().onePieceBeingDragged = true
		elif not event.pressed:
			dragging = false
			get_parent().onePieceBeingDragged = false
			print(get_parent().to_local(position).distance_to(get_parent().to_local(idealPosition)))
			if (get_parent().to_local(position).distance_to(get_parent().to_local(idealPosition)) < 1.0):
				self.position = idealPosition
				print("locked")
				if (!locked):
					locked = true
					z_index = 0
					self_modulate.a = 0.8
					pieceLocked.emit()
	
	if event is InputEventMouseMotion and dragging and !locked:
		global_position = event.position
