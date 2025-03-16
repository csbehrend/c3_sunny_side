extends Node2D

@export var numPieces: int
var correctPieces : int

var onePieceBeingDragged = false

func _ready() -> void:
	randomize()
	$"finished puzzle".hide()
	var children = get_children()
	for child in children:
		if (child.name != "finished puzzle"):
			child.pieceLocked.connect(onPieceLocked)
			child.position = Vector2(randi_range(-70, 150), randi_range(0, 110))
			child.z_index = 1
	
func onPieceLocked():
	correctPieces += 1;
	if (numPieces == correctPieces):
		$"finished puzzle".z_index = 2
		$"finished puzzle".show()
