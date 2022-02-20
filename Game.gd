extends Node2D


var scene_instance = null

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    # load scene and add to the viewport


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass



func _process(delta):
    pass
    if(!visible):
        return
    pass
#    var img = $Viewport.get_texture().get_data()
#    img.flip_y()
#    # Convert Image to ImageTexture.
#    var tex = ImageTexture.new()
#    tex.create_from_image(img)
#
#    var atlas_tex = AtlasTexture.new()
#    atlas_tex.atlas = tex
#    atlas_tex.region = Rect2(Vector2(0, 0), Vector2(400,400))
#    $TextureRect.texture = atlas_tex
    $TextureRect.texture = $Viewport.get_texture()


func init_game(level, num_pieces):
    pass
    print("(level,num_pices) = (" + str(level) + "," + str(num_pieces))
    scene_instance = load("res://levels/dragon_fly/Main.tscn").instance()
    $Viewport.add_child(scene_instance)

func stop_game():
    """
    stop game processes
    """
    pass
    print("stop_game()")
    $Viewport.remove_child(scene_instance)
    scene_instance = null

func _on_ButtonExit_button_up():
    pass # Replace with function body.
    stop_game()
    get_parent().change_scene_title()
