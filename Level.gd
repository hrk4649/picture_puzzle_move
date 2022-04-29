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

func _ready():
    pass # Replace with function body.
    init_item_list()

func init_item_list():
    pass
    $ItemList.clear()
    for level in levels:
        pass
        $ItemList.add_item(level.text)

func grab_focus():
    pass
    $ItemList.grab_focus()
    #$ItemList.select(0)

func choose_level(index):

    if index >= 0 and index < levels.size():
        var selected = levels[index]
        var level = selected["level"]
        var num_pieces = selected["num_pieces"]
        get_parent().change_scene_game(level, num_pieces)

func _on_Button_pressed():
    pass # Replace with function body.
    var items = $ItemList.get_selected_items()
    if items != null and items.size() == 1:
        $ItemList.unselect_all()
        var index = items[0]
        choose_level(index)


func _on_ItemList_item_activated(index):
    pass # Replace with function body.
    $ItemList.unselect_all()
    choose_level(index)
