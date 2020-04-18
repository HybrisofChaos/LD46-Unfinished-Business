extends Node2D

const LOOP = preload("res://Objects/Loop.tscn")
const LINK = preload("res://Objects/Link.tscn")

export (int) var loops = 1
export (NodePath) var player
export (NodePath) var target

var distance
var direction
var rot

func _ready():
	var parent = get_node(player)
	target = get_node(target)
	position = parent.global_position

	distance = (target.position - position).length()
	direction = (target.position - position).normalized()
	loops = int(distance / 2)
	rot = get_angle_to(target.position)

	for _i in range (loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
	
	if target != null:
		addLink(parent, target)

func addLoop(parent):
	var loop = LOOP.instance()
	loop.position = parent.position
	loop.position += direction * 2
	loop.look_at(parent.position)
	loop.rotation += PI / 2
	add_child(loop)

	return loop
	
func addLink(parent, child):
	var pin = LINK.instance()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)
