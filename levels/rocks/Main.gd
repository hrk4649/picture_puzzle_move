extends Spatial


var Rock = load(get_script().resource_path.get_base_dir() + "/Rock.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    $Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Timer_timeout():
    pass # Replace with function body.
    var rock = Rock.instance()
    var position_x = rand_range(
        $Markers/Marker1.global_transform.origin.x,
        $Markers/Marker2.global_transform.origin.x
        )
    var position_y = rand_range(
        $Markers/Marker1.global_transform.origin.y,
        $Markers/Marker2.global_transform.origin.y
        )
    var position_z = rand_range(
        $Markers/Marker1.global_transform.origin.z,
        $Markers/Marker2.global_transform.origin.z
        )
    rock.global_transform.origin = Vector3(position_x,position_y,position_z)
    add_child(rock)


func _on_Area_body_exited(body):
    pass # Replace with function body.
    body.queue_free()
