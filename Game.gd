extends Node2D

var Piece = preload("res://parts/Piece.tscn")
var Board = preload("res://Board.gd")

enum GameState {INIT, SHUFFLE, PLAY, CHANGE, FINISH}
enum InputDevice {KEY_DPAD, MOUSE_TOUCH}

var game_state = GameState.INIT
var scene_instance = null
var num_pieces = 9
var piece_size = Vector2(100,100)
var top_left_position = Vector2(100,100)
var pieces
var board
var key_hook = false
var cursor = null
var grabbedPiece = null
var input_device = InputDevice.KEY_DPAD

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
        GameState.SHUFFLE:
            change_texture_rect(delta)
            var shuffle_finished = true
            for i in range(0, num_pieces):
                var tr = pieces[i]
                if tr.anim_player.is_playing():
                    shuffle_finished = false
                    break
            if shuffle_finished:
                print("reset key_hook")
                key_hook = false
                # game clear check
                if board.is_all_piece_on_correct_place():
                    game_clear()
                else:
                    game_state = GameState.PLAY
        GameState.PLAY:
            change_texture_rect(delta)
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
            pass
            print("no process for game_state " + str(game_state))

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept") and !key_hook:
        input_device = InputDevice.KEY_DPAD
        key_pressed = true
    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        input_device = InputDevice.MOUSE_TOUCH
        key_pressed = true

    if key_pressed and !key_hook:
        game_state = GameState.PLAY
        cursor = Vector2(0,0)
        print_input()
        # shffle pieces
        var shuffled = board.get_shuffled_piece_array()
        board.pieces = shuffled
        
        move_pieces_animation()
        game_state = GameState.SHUFFLE
    return key_pressed

func input_play(event):
    pass
    var key_pressed = false 
    if event is InputEventKey:
        input_device = InputDevice.KEY_DPAD
        key_pressed = input_play_key(event)
        set_pieces_color()
    elif event is InputEventMouseButton:
        input_device = InputDevice.MOUSE_TOUCH
        key_pressed = input_play_mouse(event)
        set_pieces_color()
    return key_pressed
        
func input_play_key(event):

    var key_pressed = false

    # move cursor
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
        cursor.x = wrapi(cursor.x + dx, 0, board.get_num_piece_x())
        cursor.y = wrapi(cursor.y + dy, 0, board.get_num_piece_y())
        
        if accept_pressed:
            input_play_select()

        print_input()

    return key_pressed 

func input_play_mouse(event):
    print("input_play_mouse:position:" +str(event.position) + " global:" + str(event.global_position))

    # assume pressed if index is not BUTTON_LEFT
    if event.button_index != BUTTON_LEFT:
        return true

    if event.pressed == false:
        return false

    var key_pressed = false

    # check which piece is pressed
    var num = board.get_board_num(event.position - top_left_position)
    if num != -1:
        cursor = board.get_board_cursor(num)
        key_pressed = true

    print("input_play_mouse:num:" +str(num) + " cursor:" + str(cursor))
    print("input_play_mouse:key_pressed:" +str(key_pressed) + " key_hook:" + str(key_hook))
    
    if key_pressed and !key_hook:
        input_play_select()

    return key_pressed

func input_play_select():
    print("input_play_select:cursor:" +str(cursor) + " grabbedPiece:" + str(grabbedPiece))
    pass
    if grabbedPiece == null:
        grabbedPiece = Vector2(cursor)
        select_piece_animation()
        # for debug
        # game_clear()
    else:
        pass
        # change piece
        var piece1_idx = board.get_piece_num(grabbedPiece.x, grabbedPiece.y)
        var piece2_idx = board.get_piece_num(cursor.x, cursor.y)
        var piece1_value = board.pieces[piece1_idx]
        var piece2_value = board.pieces[piece2_idx]
        board.pieces[piece1_idx] = piece2_value
        board.pieces[piece2_idx] = piece1_value
        # reset
        grabbedPiece = null
        move_pieces_animation()
        game_state = GameState.SHUFFLE

func game_clear():
    game_state = GameState.FINISH
    var label = $GameClear
    remove_child(label)
    add_child(label)
    $GameClear.visible = true
    key_hook = true

    # reset select
    cursor = null
    grabbedPiece = null
    set_pieces_color()

func input_finish(event):
    pass 
    var key_pressed = false
    if event.is_action_pressed("ui_accept"):
        key_pressed = true
    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        key_pressed = true

    if key_pressed and !key_hook:
        print_input()
        return_title()
        
    return key_pressed
    
func set_pieces_color():
    pass
    if pieces == null:
        return
    var grab_idx = null
    if grabbedPiece != null:
        grab_idx = board.get_piece_num(grabbedPiece.x, grabbedPiece.y)
    
    var cursor_idx = null
    if cursor != null and input_device == InputDevice.KEY_DPAD:
        cursor_idx = board.get_piece_num(cursor.x, cursor.y)
    
    for idx1 in range(0, num_pieces):
        var idx2 = board.pieces[idx1]
        var tr = pieces[idx2]
        var color = Color(1,1,1,0)
        if idx1 == grab_idx or idx1 == cursor_idx:
            color = Color(1,1,1,0.5)
        tr.color_rect.color = color

func select_piece_animation():
    pass
    if pieces == null:
        return
    var grab_idx = null
    if grabbedPiece != null:
        grab_idx = board.get_piece_num(grabbedPiece.x, grabbedPiece.y)
    for idx1 in range(0, num_pieces):
        var idx2 = board.pieces[idx1]
        var tr = pieces[idx2]
        if idx1 == grab_idx:
            tr.select_animation()    

func print_input():
    pass
    print("cursor = " + str(cursor))
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
        var position = board.get_viewport_position(i)
        atlas_tex.region = Rect2(position, piece_size)
        tr.texture = atlas_tex

func init_game(level, num_pieces):
    pass
    key_hook = true
    print("(level,num_pices) = (" + str(level) + "," + str(num_pieces) + ")")

    self.num_pieces = num_pieces
    scene_instance = load("res://levels/dragon_fly/Main.tscn").instance()
    $Viewport.add_child(scene_instance)
    init_pieces(num_pieces)
    cursor = null
    game_state = GameState.INIT
    board.init(num_pieces, piece_size)
    $GameClear.visible = false

func init_pieces(num_pieces):    
    # prepare pieces TextureRect
    pieces = []
    for i in range(0, num_pieces):
        #var tr = TextureRect.new()
        var tr = Piece.instance()
        var position = board.get_board_position(i) + top_left_position
        tr.set_position(position)
        tr.set_size(piece_size)
        tr.rect_pivot_offset = piece_size / 2
        
        pieces.push_back(tr)
        var logstr = "position:" + str(tr.rect_global_position) + " visible:" + str(tr.visible) 
        print(logstr)
        add_child(tr)

#func move_pieces():
#    pass
#    for idx in range(0, num_pieces):
#        var idx_p = board.pieces[idx]
#        var tr = pieces[idx_p]
#        var position = board.get_board_position(idx) + top_left_position
#        tr.set_position(position)

func move_pieces_animation():
    pass
    for idx in range(0, num_pieces):
        var idx_p = board.pieces[idx]
        var tr = pieces[idx_p]
        var next_position = board.get_board_position(idx) + top_left_position
        var current_position = tr.rect_position
        if next_position != current_position:
            tr.move_animation(next_position)
    
func move_piece_animation(idx_p, next_position):
    pass
    var tr = pieces[idx_p]
    tr.move_animation(next_position)


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
