extends Node2D

var Piece = preload("res://parts/Piece.tscn")

enum GameState {INIT, SHUFFLE, PLAY, CHANGE, FINISH}

var game_state = GameState.INIT

var scene_instance = null

var num_pieces = 9

var piece_size = Vector2(100,100)

var top_left_position = Vector2(100,100)

var pieces

var key_hook = false

var cursol = null

var grabbedPiece = null

func _ready():
    pass # Replace with function body.
    top_left_position = $PieceTopLeft.position

func _process(delta):
    pass
    if(!visible):
        return
    pass
    input(delta)
    change_texture_rect(delta)
    select_piece()

func input(delta):
    match game_state:
        GameState.INIT:
            key_hook = input_init()
        GameState.PLAY:
            key_hook = input_play()
        GameState.FINISH:
            key_hook = input_finish()
        _:
            print("no process for game_state " + str(game_state))

func input_init():
    pass
    var key_pressed = false
    if Input.is_action_pressed("ui_accept"):
        game_state = GameState.PLAY
        cursol = Vector2(0,0)
        print_input()
        key_pressed = true
    return key_pressed

func input_play():
    pass 

    var key_pressed = false

    # move cursol
    var dx = 0
    var dy = 0

    var accept_pressed = false
    
    if Input.is_action_pressed("ui_left"):
        dx = -1
        key_pressed = true
    elif Input.is_action_pressed("ui_right"):
        dx = 1
        key_pressed = true
    elif Input.is_action_pressed("ui_up"):
        dy = -1
        key_pressed = true
    elif Input.is_action_pressed("ui_down"):
        dy = 1
        key_pressed = true
    elif Input.is_action_pressed("ui_accept"):
        accept_pressed = true
        key_pressed = true

    if key_pressed and !key_hook:
        pass
        cursol.x = wrapi(cursol.x + dx, 0, int(sqrt(num_pieces)))
        cursol.y = wrapi(cursol.y + dy, 0, int(sqrt(num_pieces)))
        
        if accept_pressed:
            if grabbedPiece == null:
                grabbedPiece = Vector2(cursol)
            else:
                pass
                # change piece
                
                # reset
                grabbedPiece = null
        print_input()

    return key_pressed 

func input_finish():
    pass 
    var key_pressed = false
    if Input.is_action_pressed("ui_accept"):
        print_input()
        key_pressed = true
    return key_pressed
    
func select_piece():
    pass
    var grab_idx = null
    if grabbedPiece != null:
        grab_idx = grabbedPiece.y * int(sqrt(num_pieces)) + grabbedPiece.x
    
    var cursol_idx = null
    if cursol != null:
        cursol_idx = cursol.y * int(sqrt(num_pieces)) + cursol.x
    
    for idx in range(0, num_pieces):
        var tr = pieces[idx]
        var color = Color(1,1,1,0)
        if idx == grab_idx or idx == cursol_idx:
            color = Color(1,1,1,0.5)
        tr.color_rect.color = color

func print_input():
    pass
    print("cursol = " + str(cursol))
    print("grabbedPiece = " + str(grabbedPiece))
    print("game_state = " + str(game_state))


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
    cursol = null
    game_state = GameState.INIT

func init_pieces(num_pieces):    
    # prepare pieces TextureRect
    pieces = []
    for i in range(0, num_pieces):
        #var tr = TextureRect.new()
        var tr = Piece.instance()
        var position = get_initial_position(i) + top_left_position
        tr.set_position(position)
        tr.set_size(piece_size)
        
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

func _input(event):
    pass

func _on_ButtonExit_button_up():
    pass # Replace with function body.
    stop_game()
    get_parent().change_scene_title()
