extends Spatial

var MapleLeaf = load(get_script().resource_path.get_base_dir() + "/MapleLeaf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _on_Timer_timeout():
    pass # Replace with function body.
    var leaf = MapleLeaf.instance()
    #var position = Vector3(rand_range(-10, 10), 0, rand_range(-10, 10))
    add_child(leaf)
    var rotation_y = randi() % 2 * 180
    leaf.rotation_degrees = Vector3(0, rotation_y, 0)
    var position_x = rand_range(- $AppearanceArea.width / 2, $AppearanceArea.width / 2)
    var position_y = $Start.global_transform.origin.y
    var position = Vector3(position_x, position_y, 0)
    leaf.global_transform.origin = position

    $Timer.wait_time = rand_range(0.5, 3)
