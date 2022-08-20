extends Node2D


var DragonFly = load(get_script().resource_path.get_base_dir() + "/DragonFly.tscn")

func _ready():
    pass # Replace with function body.

func _on_Timer_timeout():
    pass # Replace with function body.
    var dragon_fly = DragonFly.instance()
    add_child(dragon_fly)
    
    var location = $Path2D/PathFollow2D
    location.offset = randi()
    dragon_fly.position = location.position
    
    var direction = location.rotation
    direction += rand_range(deg2rad(-45),deg2rad(45))
    dragon_fly.rotation = direction
    dragon_fly.set_velocity_by_rotation()
