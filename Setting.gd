extends Control
onready var ResOptionButton = $MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Video/HBoxContainer/OptionButton
var Resolution:Dictionary={
	#"3840x2160":Vector2(3840,2160),
	#"2560x1440":Vector2(2560,1440),
	#"1920x1080":Vector2(1920,1080),
	#"1366x768":Vector2(1366,768),
	#"1536x864":Vector2(1536,864),
	#"1280x720":Vector2(1280,720),
	#"1440x900":Vector2(1440,900),
	"Standart 1024x600":Vector2(1024,600),
	"800x600":Vector2(800,600)
}
signal Turning_Off_Visibility()

onready var num_m = $MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Music/Master/HBox/num_m

onready var num_music = $MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Music/Music/Master2/num_Music

onready var label = $MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Music/SoundFX/HBox/Label



func _ready():
	AddResolution()
#--------VISIBLE----------------------------------------------
func _ResponsibleForDisplay(is_visible):
	visible=is_visible
	if !is_visible:
		emit_signal("Turning_Off_Visibility") 
	
#-------------------------------------------------------------


#------------VIDEO----------------------------------------------
func AddResolution()->void:
	var CurrentResolution =get_viewport().get_size()
	var Index=0
	for r in Resolution:
		ResOptionButton.add_item(r,Index)
		if Resolution[r]==CurrentResolution:
			ResOptionButton._select_int(Index)
		Index+=1
func _on_OptionButton_item_selected(index):
	var size=Resolution.get(ResOptionButton.get_item_text(index))
	OS.set_window_size(size)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)
	
func _on_FullRectbut_toggled(button_pressed):
	OS.window_fullscreen=button_pressed
	pass # Replace with function body.

func _on_Borderlessbut_toggled(button_pressed):
	OS.window_borderless=button_pressed
	pass # Replace with function body.
#---------------------------------------------------------------

#------------AUDIO----------------------------------------------
func valume(bus_index,value):
	AudioServer.set_bus_volume_db(bus_index,value)

func _on_Master_value_changed(value):
	num_m.set_text(str(value))
	valume(0,value)

func _on_Music_value_changed(value):
	num_music.set_text(str(value))
	valume(1,value)

func _on_SoundFX_value_changed(value):
	label.set_text(str(value))
	valume(2,value)
#---------------------------------------------------------------







