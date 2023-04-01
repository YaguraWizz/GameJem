extends Control
onready var Setting
onready var color=$ColorRect
export var PrefabGame:String
export var Background:Texture
signal ResponsibleForDisplay()
enum State {NEW_GAME=0,SETTING=1,EXIT=2}

var block:bool=false
func _on_Button_pressed(num_button):
	match num_button:
		State.NEW_GAME:
			if !block and PrefabGame.is_abs_path():
				var _scene=get_tree().change_scene(PrefabGame)
				print("new")
			pass
		State.SETTING:
			block=true
			print("seting")
			emit_signal("ResponsibleForDisplay")
			pass
		State.EXIT:
			if !block:
				print("exit")
				get_tree().quit()
			pass
func _on_Setting_Turning_Off_Visibility():
	block=false
	print(block)
	pass # Replace with function body.
