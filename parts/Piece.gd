extends TextureRect


var color_rect

func _ready():
    color_rect = $ColorRect
    color_rect.rect_size = self.rect_size
