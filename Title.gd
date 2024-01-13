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
	AdsManager.connect("init_completed", self, "_on_ad_init_completed")
	AdsManager.connect("ad_loaded", self, "_on_ad_loaded")
	AdsManager.connect("earned_rewarded", self, "_on_earned_rewarded")
	AdsManager.connect("ad_closed", self, "_on_ad_closed")

func init_coin() -> void:
	coin.text = "YOUR COIN: %s" % CoinManager.get_coin()
	start.disabled = !CoinManager.has_coin(coin_to_play)

func init_button() -> void:
	watch_ad.disabled = !AdsManager.is_loaded()
	get_coin.disabled = false

func init_title():
	print("init_title")
	init_coin()
	init_button()
	if AdsManager.is_available() && !AdsManager.is_loaded():
		AdsManager.load_ad()

func grab_focus():
	pass
	$Start.grab_focus()

func _on_Credit_pressed():
	$AudioStreamPlayer.play()
	get_parent().change_scene_credit()

func _on_Start_pressed():
	if CoinManager.has_coin(coin_to_play):
		CoinManager.use_coin(coin_to_play)
		$AudioStreamPlayer.play()
		get_parent().change_scene_level()

func _on_ad_init_completed(status, adapter_name):
	print("_on_ad_init_completed")
	AdsManager.load_ad()

func _on_ad_loaded():
	print("_on_ad_loaded")
	watch_ad.disabled = false

func _on_earned_rewarded(currency, amount):
	print("_on_earned_rewarded")
	CoinManager.add_coin(amount)
	#CoinManager.add_coin(1)

func _on_ad_closed():
	print("_on_ad_closed")
	watch_ad.disabled = true
	get_coin.disabled = true
	init_coin()

func _on_GetCoin_pressed():
	CoinManager.add_coin(1)
	watch_ad.disabled = true
	get_coin.disabled = true
	init_coin()
	
func _on_WatchAd_pressed():
	AdsManager.show_ad()
