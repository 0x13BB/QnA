extends Button

func _ready():
	self.connect("pressed", self, "_button_pressed")


func _button_pressed():
	
	get_parent().get_node("start").set_visible(false)
	get_parent().get_node("exit").set_visible(false)
	

	get_parent().get_node("Game").set_visible(true)
