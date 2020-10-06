extends Control

var player_words = []
var prompts = ["a name", "a noun", "adjective"]
var story = "Once upon a time %s watched a movie called %s and thought it was %s" 
var first_time_flag = true

onready var player_text = $VBoxContainer/HBoxContainer/PlayerText
onready var display_text = $VBoxContainer/DisplayText

func _ready():
#	#get_node("Label").text = text
	display_text.text = "Welcome to the LoonyLips! Prese ok to start!"
	player_text.grab_focus()
	
func start_game():
	check_player_words_length()

func _on_PlayerText_text_entered(new_text):
#	update_DisplayText(new_text)
	handle_player_input() 


func _on_TextureButton_pressed():
	handle_player_input() 
#	update_DisplayText(player_text.text)
#	# Replace with function body.

func handle_player_input():
	if first_time_flag:
		first_time_flag = false
		start_game()
	else:
		add_to_player_words() 

func update_DisplayText(words):
	pass
#	display_text.text = words
#	player_text.clear()
	
func add_to_player_words():
	player_words.append(player_text.text)
	player_text.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == prompts.size()
	
func check_player_words_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	display_text.text = story % player_words
	player_words.clear()
	display_text.text += "\n (press ok to restart)"
	first_time_flag = true
	
func prompt_player():
	display_text.text = 	"May I have " + prompts[player_words.size()] + " please?"
