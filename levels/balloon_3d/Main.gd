extends Spatial

var Balloon = load(get_script().resource_path.get_base_dir() + "/Balloon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _on_Timer_timeout():
    pass # Replace with function body.
    var balloon = Balloon.instance()
    #var position = Vector3(rand_range(-10, 10), 0, rand_range(-10, 10))
    add_child(balloon)
    var position = $Start.global_transform.origin
    balloon.global_transform.origin = position
