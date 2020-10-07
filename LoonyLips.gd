extends Control

var player_words = []

var first_time_flag = true
var template = [
		{"prompts": ["a name", "a noun", "adjective"],
		"story":"Once upon a time %s watched a movie called %s and thought it was %s"},
		{"prompts": ["a hobby", "adverb", "verb"],
		"story":"I know you like %s, which is like a dog eating its food %s because the dog wants to %s"},
		{"prompts": ["a thing", "verb", "feeling"],
		"story":"Things like %s usuaaly are hard to %s, this will make us %s"},
		{"prompts": ["a noun", "adjective", "adverb"],
		"story":"You have no idea of %s because it is so %s that we may have to think abou it %s"},
		{"prompts": ["a thing", "a name", "a description word(an adjective)", "a thing"],
		"story":"There once was %s called %s that lived as %s as a %s"}
]
var current_story 
onready var player_text = $VBoxContainer/HBoxContainer/PlayerText
onready var display_text = $VBoxContainer/DisplayText
onready var button_label_text = $VBoxContainer/HBoxContainer/TextureButton/ButtonLabel 

func _ready():
#	#get_node("Label").text = text
	select_story()
	display_text.text = "Welcome to the LoonyLips! You will give input to make a full story. Prese ok when you are ready!"
	player_text.visible = false
	
	
func select_story():
	randomize()
	current_story = template[randi() % template.size()]
	
func start_game():
	check_player_words_length()

func _on_PlayerText_text_entered(new_text):
#	update_DisplayText(new_text)
	handle_player_input() 


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
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
	return player_words.size() == current_story.prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		player_text.visible = true
		player_text.grab_focus()

func tell_story():
	display_text.text = current_story.story % player_words
	#player_words.clear()
	#display_text.text += "\n (press ok to restart)"
	#first_time_flag = true
	
func prompt_player():
	display_text.text = 	"May I have " + current_story.prompts[player_words.size()] + " please?"

func end_game():
	player_text.queue_free()
	tell_story()
	display_text.text += "\n (press ok to restart)"
	
	
