extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func change_scene_level():
    pass
    $Title.visible = false
    $Game.visible = false

    $Level.visible = true

func change_scene_game(level, num_pieces):
    pass
    $Title.visible = false
    $Level.visible = false

    $Game.visible = true
    $Game.init_game(level, num_pieces)
    
func change_scene_title():
    pass
    $Game.visible = false
    $Level.visible = false

    $Title.visible = true

