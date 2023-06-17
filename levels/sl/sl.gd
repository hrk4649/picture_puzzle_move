extends KinematicBody


onready var chimney_position = get_node("%ChimneyPosition")

func _ready():
    pass # Replace with function body.

func get_chimney_global_position():
    return chimney_position.global_translation

