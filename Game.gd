extends Node2D


var scene_instance = null

var num_pieces = 9

var piece_size = Vector2(100,100)

var top_left_position = Vector2(100,100)

var pieces

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    # load scene and add to the viewport
    top_left_position = $PieceTopLeft.position


func _process(delta):
    pass
    if(!visible):
        return
    pass
    change_texture_rect(delta)

func change_texture_rect(delta):
    var tex = $Viewport.get_texture()
    for i in range(0, num_pieces):
        var tr = pieces[i]
        var atlas_tex = AtlasTexture.new()
        atlas_tex.atlas = tex
        var position = get_picture_position(i)
        atlas_tex.region = Rect2(position, piece_size)
        tr.texture = atlas_tex
    
func get_initial_position(idx = 0):
    var num = int(sqrt(num_pieces))
    var x = (idx % num) * piece_size.x * 1.05
    var y = int(idx / num) * piece_size.y * 1.05
    return Vector2(x,y)

func get_picture_position(idx = 0):
    var num = int(sqrt(num_pieces))
    var x = (idx % num) * piece_size.x
    var y = int(idx / num) * piece_size.y
    return Vector2(x,y)

func init_game(level, num_pieces):
    pass
    print("(level,num_pices) = (" + str(level) + "," + str(num_pieces) + ")")

    self.num_pieces = num_pieces
    scene_instance = load("res://levels/dragon_fly/Main.tscn").instance()
    $Viewport.add_child(scene_instance)
    init_pieces(num_pieces)

func init_pieces(num_pieces):    
    # prepare pieces TextureRect
    pieces = []
    for i in range(0, num_pieces):
        var tr = TextureRect.new()
        var position = get_initial_position(i) + top_left_position
        tr.set_position(position)
        tr.set_size(piece_size)

        #tr.hint_tooltip = str(i)
        
        pieces.push_back(tr)
        var logstr = "position:" + str(tr.rect_global_position) + " visible:" + str(tr.visible) 
        print(logstr)
        add_child(tr)

func stop_game():
    """
    stop game processes
    """
    pass
    print("stop_game()")
    $Viewport.remove_child(scene_instance)
    scene_instance = null
    for tr in pieces:
        remove_child(tr)
    pieces = null

func _on_ButtonExit_button_up():
    pass # Replace with function body.
    stop_game()
    get_parent().change_scene_title()
