extends Control

var levels = [
    {"level":"ufo", "text":"UFO (3 x 3)", "num_pieces":9},
    {"level":"ufo", "text":"UFO (4 x 4)", "num_pieces":16},
    {"level":"dragon_fly", "text":"Dragon Fly (3 x 3)", "num_pieces":9},
    {"level":"dragon_fly", "text":"Dragon Fly (4 x 4)", "num_pieces":16},
    {"level":"balloon_3d", "text":"Balloon (3 x 3)", "num_pieces":9},
    {"level":"balloon_3d", "text":"Balloon (4 x 4)", "num_pieces":16},
    {"level":"maple_leaves", "text":"Maple Leaves (3 x 3)", "num_pieces":9},
    {"level":"maple_leaves", "text":"Maple Leaves (4 x 4)", "num_pieces":16},
]

var LevelItem = preload("res://parts/LevelItem.tscn")

var key_hook = false

var firstLevelButton

func _ready():
    pass # Replace with function body.
    init_item_list()

func _input(event):
    if(!visible):
        return
    key_hook = input_init(event)

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept"):
        key_pressed = true

    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        key_pressed = true

    return key_pressed

func init_item_list():
    pass
    for child in $ScrollContainer/VBoxContainer.get_children():
        $ScrollContainer/VBoxContainer.remove_child(child)
    for idx in range(0,levels.size()):
        var level = levels[idx]
        pass
        var levelItem = LevelItem.instance()
        var record_time = TimeManager.get_record_time(
            level["level"],
            level["num_pieces"]
           )
        var record_time_str = "--:--"
        if record_time != null:
            record_time_str = TimeManager.get_record_time_str(record_time)
        levelItem.init(level["text"], record_time_str)
        $ScrollContainer/VBoxContainer.add_child(levelItem)
        levelItem.button.connect("pressed", self, "choose_level", [idx])
        if idx == 0:
            firstLevelButton = levelItem.button

func grab_focus():
    pass
#    $ItemList.grab_focus()
    if firstLevelButton != null:
        firstLevelButton.grab_focus()
    $ScrollContainer.scroll_vertical = 0
    #$ItemList.select(0)

func choose_level(index):
    if visible == false :
        return
    if index >= 0 and index < levels.size():
        var selected = levels[index]
        var level = selected["level"]
        var num_pieces = selected["num_pieces"]
        get_parent().change_scene_game(level, num_pieces)
