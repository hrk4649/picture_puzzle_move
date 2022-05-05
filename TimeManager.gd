extends Node

var file_name = "user://time_record.save"

var time_record = {}

func _ready():
    pass # Replace with function body.
    load_record()
    
func get_record_key(level, num_of_pieces):
    return "%s %d" % [level, num_of_pieces]

func record_time(level, num_of_pieces, time):
    pass
    var key = get_record_key(level, num_of_pieces)
    time_record[key] = time

func get_record_time(level, num_of_pieces):
    pass
    var key = get_record_key(level, num_of_pieces)
    var time = time_record.get(key)
    return time

func get_record_time_str(time):
    time = int(time)
    var minutes = time / 60
    var seconds = time % 60
    var time_str = "%02d:%02d" % [minutes, seconds]
    return time_str


# https://docs.godotengine.org/ja/stable/tutorials/io/saving_games.html#introduction

func save_record():
    pass
    var file = File.new()
    file.open(file_name, File.WRITE)
    file.store_line(to_json(time_record))
    file.close()

func load_record():
    pass
    var file = File.new()
    file.open(file_name, File.READ)
    while file.get_position() < file.get_len():
        var data = parse_json(file.get_line())
        time_record = data
    file.close()
