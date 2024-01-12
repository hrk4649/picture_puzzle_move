extends Node

signal init_completed
signal ad_loaded
signal earned_rewarded
signal ad_closed

var ad_available = false

func _ready():
	ready_admob()

func ready_admob():
	showMsg("ready_admob")
	ad_available = false
	MobileAds.connect("initialization_complete", self, "_on_initialization_complete")
	MobileAds.connect("rewarded_ad_failed_to_load", self, "_on_rewarded_ad_failed_to_load")
	MobileAds.connect("rewarded_ad_loaded", self, "_on_rewarded_ad_loaded")
	MobileAds.connect("rewarded_ad_failed_to_show", self, "_on_rewarded_ad_failed_to_show")
	MobileAds.connect("rewarded_ad_opened", self, "_on_rewarded_ad_opened")
	MobileAds.connect("rewarded_ad_clicked", self, "_on_rewarded_ad_clicked")
	MobileAds.connect("rewarded_ad_closed", self, "_on_rewarded_ad_closed")
	MobileAds.connect("rewarded_ad_recorded_impression", self, "_on_rewarded_ad_recorded_impression")
	MobileAds.connect("user_earned_rewarded", self, "_on_user_earned_rewarded")

func is_available():
	var result = ad_available
	print("AdManager.is_available():%s" % result)
	return result

func is_loaded():
	return MobileAds.get_is_rewarded_loaded()

func showMsg(message):
	print(message)

func _on_initialization_complete(status, adapter_name):
	showMsg("_on_initialization_complete: status:%s adapter_name:%s" % [status, adapter_name])
	ad_available = true
	emit_signal("init_completed", status, adapter_name)

func _on_rewarded_ad_failed_to_load(error_code):
	showMsg("_on_rewarded_ad_failed_to_load:error_code:" + str(error_code))

func _on_rewarded_ad_loaded():
	showMsg("_on_rewarded_ad_loaded")
	emit_signal("ad_loaded")

func _on_rewarded_ad_failed_to_show(error_code):
	showMsg("_on_rewarded_ad_failed_to_show:error_code:" + str(error_code))

func _on_rewarded_ad_closed():
	showMsg("_on_rewarded_ad_closed")
	emit_signal("ad_closed")

func _on_rewarded_ad_opened():
	showMsg("_on_rewarded_ad_opened")

func _on_rewarded_ad_clicked():
	showMsg("_on_rewarded_ad_clicked")
	
func _on_rewarded_ad_recorded_impression():
	showMsg("_on_rewarded_ad_recorded_impression")

func load_ad():
	if !MobileAds.get_is_rewarded_loaded():
		MobileAds.load_rewarded()

func show_ad():
	print("show_ad")
	MobileAds.show_rewarded()

func _on_user_earned_rewarded(currency, amount):
	showMsg("_on_user_earned_rewarded")
	emit_signal("earned_rewarded", currency, amount)
	
