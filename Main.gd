extends Node

func _ready():
    pass # Replace with function body.
    change_scene_title()

func change_scene_level():
    pass
    $Title.visible = false
    $Game.visible = false
    $Credit.visible = false

    $Level.visible = true
    $Level.init_item_list()
    $Level.grab_focus()

func change_scene_game(level, num_pieces):
    pass
    $Title.visible = false
    $Level.visible = false
    $Credit.visible = false

    $Game.init_game(level, num_pieces)
    $Game.visible = true

    
func change_scene_title():
    pass
    $Game.visible = false
    $Level.visible = false
    $Credit.visible = false

    $Title.visible = true
    $Title.grab_focus()

func change_scene_credit():
    pass
    $Game.visible = false
    $Level.visible = false
    $Title.visible = false

    $Credit.visible = true
    $Credit.grab_focus()
