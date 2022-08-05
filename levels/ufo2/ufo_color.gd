extends Spatial


var white_material = preload("res://levels/ufo/material_white.tres")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    var body = [$Sphere, $Cone]
    var windows = [
        $Sphere004,$Sphere005,$Sphere006,
        $Sphere007,$Sphere008,$Sphere009]
    var rockets = [
        $Sphere001,
        $Sphere002,
        $Sphere003
       ]
    for m in body:
        for idx in range(0, m.get_surface_material_count()):
            m.set_surface_material(idx, white_material)
    for m in windows:
        for idx in range(0, m.get_surface_material_count()):
            m.set_surface_material(idx, white_material)
    for m in rockets:
        for idx in range(0, m.get_surface_material_count()):
            m.set_surface_material(idx, white_material)

