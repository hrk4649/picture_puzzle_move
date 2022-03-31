extends Node


var num_pieces:int = 9

var piece_size:Vector2 = Vector2(100,100)

var margin = 0.05

var viewport_top_left = Vector2(0,0)

# int array
var pieces:Array = []

func _ready() -> void:
    randomize()

func init(num_pieces, piece_size) -> void:
    pass
    self.num_pieces = num_pieces
    self.piece_size = piece_size
    init_pieces()

func init_pieces() -> void:
    pass
    pieces = []
    for num in range(0, num_pieces):
        pieces.push_back(num)

func is_all_piece_on_correct_place() -> bool:
    pass
    var result = true
    for idx in range(0, num_pieces):
        var piece_at = pieces[idx]
        if piece_at != idx:
            result = false
            break
    return result

func get_shuffled_piece_array() -> Array:
    var shuffled = pieces.duplicate()
    # Fisher–Yates shuffle
    # https://blog.y-yuki.net/entry/2018/08/22/094000
    for idx1 in range(num_pieces - 1, 0, -1):
        var idx2 = randi() % (idx1 + 1)
        var value1 = shuffled[idx1]
        var value2 = shuffled[idx2]
        # swap values
        shuffled[idx1] = value2
        shuffled[idx2] = value1

    return shuffled

func get_num_piece_x() -> int:
    return int(sqrt(num_pieces))

func get_num_piece_y() -> int:
    return int(sqrt(num_pieces))

func get_piece_x(n:int) -> int:
    return n % get_num_piece_x()
    
func get_piece_y(n:int) -> int:
    return int(n / get_num_piece_y())

func get_piece_num(x:int, y:int) -> int:
    return x + get_num_piece_x() * y

func get_viewport_position(n:int) -> Vector2:
    return viewport_top_left + Vector2(
        get_piece_x(n) * piece_size.x,
        get_piece_y(n) * piece_size.y)

func get_board_position(n:int) -> Vector2:
    return Vector2(
        get_piece_x(n) * piece_size.x * (1.0 + margin),
        get_piece_y(n) * piece_size.y * (1.0 + margin))

func get_board_cursor(n:int) -> Vector2:
    return Vector2(get_piece_x(n), get_piece_y(n))

func get_board_num(point:Vector2) ->int:
    pass
    var result:int = -1
    for num in range(0, num_pieces):
        var rect = Rect2(get_board_position(num), piece_size)
        if rect.has_point(point):
            result = num
            break
    return result

func get_board_size() -> Vector2:
    pass
    return Vector2(
        get_num_piece_x() * piece_size.x + (get_num_piece_x() - 1) * piece_size.x *  margin,
        get_num_piece_y() * piece_size.y + (get_num_piece_y() - 1) * piece_size.y *  margin)

func calc_viewport_top_left(view_port_size:Vector2) -> void:
    pass
    var board_size_no_margin = Vector2(
        get_num_piece_x() * piece_size.x,
        get_num_piece_y() * piece_size.y
       )
    viewport_top_left = view_port_size / 2 - board_size_no_margin / 2
