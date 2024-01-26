extends Panel

@onready var game_manager = %GameManager


@onready var dialogue_text = $DialogueText

@onready var npc_icon : TextureRect = $NPCIcon
@onready var talk_input : TextEdit = $PlayerTalkInput
@onready var talk_button : Button = $TalkButton
@onready var leave_button : Button = $LeaveButton
@onready var chat_gpt_interface = $"../../ChatGptInterface"


# Called when the node enters the scene tree for the first time.
func _ready():
	chat_gpt_interface.on_player_talk.connect(_on_player_talk)
	chat_gpt_interface.on_npc_talk.connect(_on_npc_talk)

# called when the player begins talking to an NPC
func initialize_with_npc (npc):
	npc_icon.texture = npc.icon
	dialogue_text.text = ""
	talk_button.disabled = true

# called when the TalkButton is pressed
func _on_talk_button_pressed():
	game_manager.dialogue_request(talk_input.text)

# called when the LeaveButton is pressed
func _on_leave_button_pressed():
	game_manager.exit_dialogue()

# called when the player sends a message
func _on_player_talk ():
	talk_input.text = ""
	dialogue_text.text = "Hmm..."
	talk_button.disabled = true

# called when the NPC sends us a message
func _on_npc_talk (npc_dialogue):
	dialogue_text.text = npc_dialogue
	talk_button.disabled = false
