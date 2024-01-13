extends Node

var MAX_COIN = 10

var coin:int = 3 setget set_coin, get_coin

func set_coin(value) -> void:
	pass

func get_coin() -> int:
	return coin

func add_coin(value:int) -> void:
	coin = clamp(coin + value, 0, MAX_COIN)

func has_coin(value:int) -> bool:
	return value <= coin
 
func use_coin(value:int) -> bool:
	if value <= coin:
		coin = clamp(coin - value, 0, MAX_COIN)
		print("use_coin:spend %s" % value)
		return true
	else:
		return false
