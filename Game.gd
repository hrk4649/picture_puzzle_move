extends Node2D

var Piece = preload("res://parts/Piece.tscn")

var Board = preload("res://Board.gd")

enum GameState {INIT, SHUFFLE, PLAY, CHANGE, FINISH}

var game_state = GameState.INIT

var scene_instance = null

var num_pieces = 9

var piece_size = Vector2(100,100)

var top_left_position = Vector2(100,100)

var pieces

var board

var key_hook = false

var cursol = null

var grabbedPiece = null

func _ready():
    pass # Replace with function body.
    top_left_position = $PieceTopLeft.position
    board = Board.new()

func _process(delta):
    pass
    if(!visible):
        return
    pass
    match game_state:
        GameState.INIT:
            change_texture_rect(delta)
        GameState.PLAY:
            change_texture_rect(delta)
            select_piece()
        GameState.FINISH:
            change_texture_rect(delta)
        _:
            print("no process for game_state " + str(game_state))

func _input(event):
    if(!visible):
        return
    match game_state:
        GameState.INIT:
            key_hook = input_init(event)
        GameState.PLAY:
            key_hook = input_play(event)
        GameState.FINISH:
            key_hook = input_finish(event)
        _:
            print("no process for game_state " + str(game_state))

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept") and !key_hook:
        key_pressed = true

    if key_pressed and !key_hook:
        game_state = GameState.PLAY
        cursol = Vector2(0,0)
        print_input()
        # shffle pieces
        var shuffled = board.get_shuffled_piece_array()
        board.pieces = shuffled
        move_pieces()
    return key_pressed

func input_play(event):
    pass 

    var key_pressed = false

    # move cursol
    var dx = 0
    var dy = 0

    var accept_pressed = false
    
    if event.is_action_pressed("ui_left"):
        dx = -1
        key_pressed = true
    elif event.is_action_pressed("ui_right"):
        dx = 1
        key_pressed = true
    elif event.is_action_pressed("ui_up"):
        dy = -1
        key_pressed = true
    elif event.is_action_pressed("ui_down"):
        dy = 1
        key_pressed = true
    elif event.is_action_pressed("ui_accept"):
        accept_pressed = true
        key_pressed = true


    if key_pressed and !key_hook:
        pass
        cursol.x = wrapi(cursol.x + dx, 0, int(sqrt(num_pieces)))
        cursol.y = wrapi(cursol.y + dy, 0, int(sqrt(num_pieces)))
        
        if accept_pressed:
            if grabbedPiece == null:
                grabbedPiece = Vector2(cursol)
                # for debug
                # game_clear()
            else:
                pass
                # change piece
                var piece1_idx = board.get_piece_num(grabbedPiece.x, grabbedPiece.y)
                var piece2_idx = board.get_piece_num(cursol.x, cursol.y)
                var piece1_value = board.pieces[piece1_idx]
                var piece2_value = board.pieces[piece2_idx]
                board.pieces[piece1_idx] = piece2_value
                board.pieces[piece2_idx] = piece1_value
                move_pieces()
                # reset
                grabbedPiece = null
                # game clear check
                if board.is_all_piece_on_correct_place():
                    game_clear()
        print_input()

    return key_pressed 

func game_clear():
    game_state = GameState.FINISH
    var label = $GameClear
    remove_child(label)
    add_child(label)
    $GameClear.visible = true
    key_hook = true

    # reset select
    cursol = null
    grabbedPiece = null
    select_piece()

    #$ButtonExit.grab_focus()

func input_finish(event):
    pass 
    var key_pressed = false
    if event.is_action_pressed("ui_accept"):
        key_pressed = true

    if key_pressed and !key_hook:
        print_input()
        return_title()
        
    return key_pressed
    
func select_piece():
    pass
    if pieces == null:
        return
    var grab_idx = null
    if grabbedPiece != null:
        grab_idx = board.get_piece_num(grabbedPiece.x, grabbedPiece.y)
    
    var cursol_idx = null
    if cursol != null:
        cursol_idx = board.get_piece_num(cursol.x, cursol.y)
    
    for idx1 in range(0, num_pieces):
        var idx2 = board.pieces[idx1]
        var tr = pieces[idx2]
        var color = Color(1,1,1,0)
        if idx1 == grab_idx or idx1 == cursol_idx:
            color = Color(1,1,1,0.5)
        tr.color_rect.color = color

func print_input():
    pass
    print("cursol = " + str(cursol))
    print("grabbedPiece = " + str(grabbedPiece))
    print("game_state = " + str(game_state))


func change_texture_rect(delta):
    if (pieces == null):
        return
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
    key_hook = true
    print("(level,num_pices) = (" + str(level) + "," + str(num_pieces) + ")")

    self.num_pieces = num_pieces
    scene_instance = load("res://levels/dragon_fly/Main.tscn").instance()
    $Viewport.add_child(scene_instance)
    init_pieces(num_pieces)
    cursol = null
    game_state = GameState.INIT
    board.init(num_pieces, piece_size)
    $GameClear.visible = false

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

func move_pieces():
    pass
    for idx in range(0, num_pieces):
        var idx_p = board.pieces[idx]
        var tr = pieces[idx_p]
        var position = get_initial_position(idx) + top_left_position
        tr.set_position(position)

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

func return_title():
    self.visible = false
    stop_game()
    get_parent().change_scene_title()   


