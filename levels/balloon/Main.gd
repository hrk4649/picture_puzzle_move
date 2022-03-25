extends Control

var Balloon = load(get_script().resource_path.get_base_dir() + "/Balloon.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func create_balloon():
    pass
    var balloon = Balloon.instance()
    add_child(balloon)
    
    var location = $Path2D/PathFollow2D
    location.offset = randi()
    balloon.position = location.position + Vector2(0,600)
    print("location.position:" + str(location.position))
    var direction = location.rotation + PI
    #var direction = 0
    #var direction = PI * 0.25
    #direction += rand_range(-PI / 4, PI / 4)
    #print("direction:" + str(direction))
    balloon.rotation = direction
    balloon.set_velocity_by_rotation()

func create_balloon2():
    pass
    var balloon = Balloon.instance()
    add_child(balloon)

    var radius = ($CircleRadius.position - $CircleCenter.position).length()
    var radian = rand_range(0, 2 * PI)
    balloon.position = Vector2(sin(radian), cos(radian)) * radius + $CircleCenter.position
    balloon.rotation = - radian
    balloon.set_velocity_by_rotation()
    balloon.init_position($CircleCenter.position)

func _on_Timer_timeout():
    pass # Replace with function body.
    #create_balloon()
    create_balloon2()
