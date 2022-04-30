extends HBoxContainer

var button

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    button = $Button

func init(title, time):
    $Labels/Title.text = title
    $Labels/BestTime.text = time
