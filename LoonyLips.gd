extends Control

var player_words = []

var first_time_flag = true

var current_story = {}
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
#	current_story = template[randi() % template.size()]
	
	#Method1(keep in the engine):
	var stories = $StoryNode.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryNode.get_child(selected_story).prompts
	current_story.story = $StoryNode.get_child(selected_story).story
	
	#Method2 (using json):
	#var stories = get_from_json("StoryBook.json")
	#current_story = stories[randi() % stories.size()]

func get_from_json(file_name):
	var json_file = File.new()
	json_file.open(file_name, File.READ)
	var content = json_file.get_as_text()
	var data = parse_json(content)
	json_file.close()
	return data

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
	
	
