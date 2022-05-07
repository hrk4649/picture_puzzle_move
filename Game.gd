extends Control

var Piece = preload("res://parts/Piece.tscn")
var Board = preload("res://Board.gd")

enum GameState {INIT, SHUFFLE, PLAY, CHANGE, FINISH}
enum InputDevice {KEY_DPAD, MOUSE_TOUCH}

var game_state = GameState.INIT
var scene_instance = null
var num_pieces = 9
var level = null
var piece_size = Vector2(100,100)
var top_left_position = Vector2(100,100)
var pieces
var board
var cursor = null
var grabbedPiece = null
var input_device = InputDevice.KEY_DPAD

var anim_play1
var anim_play2

var time_start = 0
var time = 0

func _ready():
    pass # Replace with function body.
    board = Board.new()
    anim_play1 = $AnimationPlayer1
    anim_play2 = $AnimationPlayer2

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
                if tr.is_moving():
                    shuffle_finished = false
                    break
            if shuffle_finished:
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

func init_time():
    time_start = OS.get_unix_time()
    
func calc_time():
    var time_now = OS.get_unix_time()
    time = time_now - time_start
    var curr_record = TimeManager.get_record_time(level, num_pieces)

    var message = "GAME CLEAR !"

    if curr_record == null || time < curr_record:
        message = "NEW RECORD !!"
        TimeManager.record_time(level, num_pieces, time)

    var time_str = TimeManager.get_record_time_str(time)
    $GameClear.text = "%s\n%s" % [message, time_str]
    
func _input(event):
    if(!visible):
        return
    accept_event()
    match game_state:
        GameState.INIT:
            input_init(event)
        GameState.PLAY:
            input_play(event)
        GameState.FINISH:
            input_finish(event)
        _:
            pass
            print("no process for game_state " + str(game_state))

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept"):
        input_device = InputDevice.KEY_DPAD
        key_pressed = true
    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        input_device = InputDevice.MOUSE_TOUCH
        key_pressed = true

    if key_pressed:
        game_state = GameState.PLAY
        init_time()
        cursor = Vector2(0,0)
        print_input()
        # shffle pieces
        var shuffled = board.get_shuffled_piece_array()
        board.pieces = shuffled
        
        move_pieces_animation()
        anim_play1.play("fade_in")
        game_state = GameState.SHUFFLE
    return key_pressed

func input_play(event):
    pass
    var key_pressed = false 
    if event is InputEventKey or event is InputEventJoypadButton:
        input_device = InputDevice.KEY_DPAD
        key_pressed = input_play_key(event)
        set_pieces_color()
    elif event is InputEventMouseButton:
        input_device = InputDevice.MOUSE_TOUCH
        key_pressed = input_play_mouse(event)
        set_pieces_color()
    else:
        pass
        #print("event is " + str(event))
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

    if key_pressed:
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
    
    if key_pressed:
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
    calc_time()
    anim_play1.play("fade_out")
    anim_play2.play("message")
    var label = $GameClear
    remove_child(label)
    add_child(label)

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

    if key_pressed:
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
    var tex_size = tex.get_size()
    board.calc_viewport_top_left(tex_size)
    
    # change background TextureRect
    var whole_picture = AtlasTexture.new()
    whole_picture.atlas = tex
    whole_picture.region = Rect2(Vector2.ZERO, tex_size)
    $Background.texture = whole_picture
    
    # change pieces
    for i in range(0, num_pieces):
        var tr = pieces[i]
        var atlas_tex = AtlasTexture.new()
        atlas_tex.atlas = tex
        var position = board.get_viewport_position(i)
        atlas_tex.region = Rect2(position, piece_size)
        tr.texture = atlas_tex

func init_game(level, num_pieces):
    pass
    print("(level,num_pices) = (" + str(level) + "," + str(num_pieces) + ")")
    
    self.level = level
    self.num_pieces = num_pieces
    board.init(num_pieces, piece_size)
    
    scene_instance = load("res://levels/" + level + "/Main.tscn").instance()
    $Viewport.add_child(scene_instance)
    init_top_left_position()
    init_pieces(num_pieces)
    cursor = null
    game_state = GameState.INIT
    
    $GameClear.visible = false

func init_top_left_position():
    pass
    var parent_size = rect_size
    var board_size = board.get_board_size()
    top_left_position = Vector2(
        parent_size.x / 2.0 - board_size.x / 2.0,
        parent_size.y / 2.0 - board_size.y / 2.0
       )

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

func move_pieces_animation():
    pass
    var is_move = false
    for idx in range(0, num_pieces):
        var idx_p = board.pieces[idx]
        var tr = pieces[idx_p]
        var next_position = board.get_board_position(idx) + top_left_position
        var current_position = tr.rect_position
        if next_position != current_position:
            tr.move_animation(next_position)
            is_move = true
    if is_move:
        $AudioStreamPlayer2.play()
    
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
    TimeManager.save_record()
    get_parent().change_scene_title()   
