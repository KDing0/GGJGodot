extends Node

@onready var dialogue_box = get_node("/root/Main/CanvasLayer/DialogueBox")
@onready var chat_gpt_interface = $"../ChatGptInterface"

var current_npc
var messages = []
@export_multiline var dialogue_rules : String

signal on_player_talk
signal on_npc_talk (npc_dialogue)

func _ready():
	chat_gpt_interface.appendMessage.connect(_appendMessage)
	

func _appendMessage(message):
	messages.append(message)

# called when we want to talk to the AI
func dialogue_request (player_dialogue):
	var prompt = player_dialogue
	if len(messages) == 0:
		var header_prompt = "Act as a " + current_npc.physical_description + " in a fantasy RPG. "
		header_prompt += "As a character, you are " + current_npc.personality + ". "
		header_prompt += "Your location is " + current_npc.location_description + ". "
		header_prompt += "You have secret knowledge  that you will not speak about unless asked by me: " + current_npc.secret_knowledge + ". "
		
		prompt = dialogue_rules + "\n" + header_prompt + "\nWhat is your first line of dialogue?"
		
		# add a new message to the array
	messages.append({
		"role": "user",
		"content": prompt
		})
		
	chat_gpt_interface.dialogue_request(messages)


# called when we begin talking with an NPC
func enter_new_dialogue (npc):
	messages = []
	current_npc = npc
	dialogue_box.visible = true
	dialogue_box.initialize_with_npc(npc)
	dialogue_request("")

# called when we stop talking with an NPC
func exit_dialogue ():
	messages = []
	current_npc = null
	dialogue_box.visible = false
	chat_gpt_interface.exit_dialogue()

# are we currently talking? True or False
func is_dialogue_active ():
	return dialogue_box.visible
