extends Node2D

onready var maxValue = get_children().size()
onready var value = get_children().size()

func _ready():
	pass

func setValue(v):
	self.value = v
	for i in  range(maxValue):
		var h = get_node("under" + str(i + 1) + "/health")
		if i + 1 > v:
			h.hide()
		else:
			h.show()
