extends Node2D

const LOOP = preload("res://Objects/Loop.tscn")
const LINK = preload("res://Objects/Link.tscn")

export (int) var loops = 1
export (NodePath) var target

func _ready():
	var parent = $Anchor
	target = get_node(target)

	for _i in range (loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
	
	if target != null:
		var child = addLoop(target)
		addLink(parent, child)

func addLoop(parent):
	var loop = LOOP.instance()
	loop.position = parent.position
	loop.position.y += 4
	add_child(loop)
	return loop

func addLink(parent, child):
	var pin = LINK.instance()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)
