extends Control

func _ready():
    pass # Replace with function body.
    change_scene_title()
    resize_main_node()
    get_viewport().connect("size_changed", self, "resize_main_node")

func resize_main_node():
    pass
    var vp_size = get_viewport_rect().size
    var size = self.rect_size
    var new_scale = Vector2.ZERO
    if vp_size.x > vp_size.y:
        new_scale = vp_size.y / size.y
    else:
        new_scale = vp_size.x / size.x
        
    self.rect_scale = Vector2(new_scale, new_scale)
    $Game.control_scale = Vector2(new_scale, new_scale)

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
