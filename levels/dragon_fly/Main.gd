extends Node2D


var DragonFly = load(get_script().resource_path.get_base_dir() + "/DragonFly.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Timer_timeout():
    pass # Replace with function body.
    var dragon_fly = DragonFly.instance()
    add_child(dragon_fly)
    
    var location = $Path2D/PathFollow2D
    location.offset = randi()
    dragon_fly.position = location.position
    
    var direction = location.rotation # + PI / 2
    #var direction = 0
    #var direction = PI * 0.25
    direction += rand_range(-PI / 4, PI / 4)
    #print("direction:" + str(direction))
    dragon_fly.rotation = direction
    dragon_fly.set_velocity_by_rotation()
