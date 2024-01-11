extends Control

onready var coin = $Coin
onready var watch_ad = $HBoxContainer/WatchAd
onready var get_coin = $HBoxContainer/GetCoin
onready var start = $Start

var coin_to_play = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AnimationPlayer.play("forth_and_back")
	if AdsManager.is_available():
		AdsManager.connect("ad_loaded", self, "_on_ad_loaded")
		AdsManager.connect("earned_rewarded", self, "_on_earned_rewarded")

func update_coin_text() -> void:
	coin.text = "YOUR COIN: %s" % CoinManager.get_coin()
	start.disabled = !CoinManager.has_coin(coin_to_play)

func init_buttons():
	update_coin_text()
	watch_ad.disabled = true
	get_coin.disabled = false
	if AdsManager.is_available():
		AdsManager.load_ad()

func grab_focus():
	pass
	$Start.grab_focus()

func _on_Credit_pressed():
	pass # Replace with function body.
	$AudioStreamPlayer.play()
	get_parent().change_scene_credit()

func _on_Start_pressed():
	if CoinManager.has_coin(coin_to_play):
		CoinManager.use_coin(coin_to_play)
		$AudioStreamPlayer.play()
		get_parent().change_scene_level()

func _on_ad_loaded():
	print("_on_ad_loaded")
	watch_ad.disabled = false

func _on_earned_rewarded(currency, amount):
	print("_on_earned_rewarded")
	CoinManager.add_coin(amount)

func _on_GetCoin_pressed():
	CoinManager.add_coin(1)
	get_coin.disabled = true
	update_coin_text()
	

